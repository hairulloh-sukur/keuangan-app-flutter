// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import './auth_controller.dart';
import '../constants.dart';
import '../models/stok_sum_model.dart';
import '../models/total_sum_model.dart';
import '../models/data_sum_model.dart';
import '../models/saldo_sum_model.dart';

class HomeController extends GetxController {
  final apiKeuangan = urlKeuangan + 'API/';

  final authController = Get.find<AuthController>();

  List<DataSum> _listDataSum = [];
  List<DataSum> get listDataSum => _listDataSum.obs;

  List<TotalSum> _listTotalSum = [];
  List<TotalSum> get listTotalSum => _listTotalSum.obs;

  TotalSum _grandTotalSum = TotalSum(
      outletId: '99',
      outletName: 'TOTAL',
      totalIdr: '0',
      totalUsd: '0',
      totalEur: '0',
      totalSgd: '0');

  TotalSum get grandTotalSum => _grandTotalSum;

  // *getSaldoStokSum
  Future<void> getSaldoStokSum({
    required String userId,
    required String outletId,
  }) async {
    _listDataSum = [];
    _listTotalSum = [];

    // *Awal Get API data Saldo Sum
    Uri urlSaldo = Uri.parse(apiKeuangan + 'Sum/GetSaldo');

    List listSaldoSum = []; // *Model SaldoSum, data dari API

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };
      var request = http.Request('GET', urlSaldo);
      request.body = json.encode({
        "act": "sumSaldoTrx",
        "outlet_id": 1,
        "user_id": int.parse(userId),
        "data1": {
          "Outlet_id": 1,
          "sum_get_outlet": int.parse(outletId),
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Saldo Summary');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

        if (data['status']['error'] == 1) {
          Get.snackbar(
            "error",
            "Server Maintenance!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.amber[50],
            borderWidth: 1,
            borderColor: Colors.amber,
            margin: EdgeInsets.all(15),
          );

          throw ('Server Maintenance');
        }

        // print(data['data']);

        // *List Saldo Sum dari API
        if (data['data'] != null) {
          data['data'].map((e) {
            listSaldoSum.add(
              SaldoSum(
                outletAsal: e['outlet_asal'],
                mataUang: e['mata_uang'],
                jumlah: e['jumlah'],
                debet: e['Debet'],
                kredit: e['Kredit'],
              ),
            );
          }).toList();
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    // *Akhir Get API data Saldo Sum

    // *Awal Get API data Stok Sum
    Uri urlStok = Uri.parse(apiKeuangan + 'Sum/GetNilaiStok');

    List listStokSum = []; // *Model StokSum, data dari API

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };
      var request = http.Request('GET', urlStok);
      request.body = json.encode({
        "act": "sumNilaiStok",
        "outlet_id": 1,
        "user_id": int.parse(userId),
        "data1": {"Outlet_id": 1, "sum_get_outlet": int.parse(outletId)}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Stok Summary');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

        // print(data['data']);

        // *List Stok Sum dari API
        if (data['data'] != null) {
          data['data'].map((e) {
            listStokSum.add(
              StokSum(
                outletAsal: e['outlet_asal'],
                mataUang: e['mata_uang'],
                jumlah: e['jumlah'],
                nilai: e['Nilai'],
              ),
            );
          }).toList();
        }

        // print(listStokSum);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    // *Akhir Get API data Stok Sum

    List listAllSaldoSum =
        []; // *Model SaldoSum, tetapi data seluruh outlet dan currency

    List listAllStokSum =
        []; // *Model StokSum, tetapi data seluruh outlet dan currency

    // *Untuk melisting seluruh outlet
    for (var eListOutlet in authController.listOutlet) {
      // print(eListOutlet.id);
      // *Untuk melisting seluruh currency
      for (var eListCurrency in authController.listCurrency) {
        // print(eListCurrency.ctNama);

        // *Awal SaldoSum
        SaldoSum dataSaldo = listSaldoSum.firstWhere(
          (element) => (element.outletAsal == eListOutlet.id &&
              element.mataUang == eListCurrency.ctNama),
          orElse: () => SaldoSum(
            outletAsal: eListOutlet.id,
            mataUang: eListCurrency.ctNama,
            jumlah: '0',
            debet: '0',
            kredit: '0',
          ),
        );

        listAllSaldoSum.add(
          SaldoSum(
              outletAsal: eListOutlet.id,
              mataUang: eListCurrency.ctNama,
              jumlah: dataSaldo.jumlah,
              debet: dataSaldo.debet,
              kredit: dataSaldo.kredit),
        );
        // *Akhir SaldoSum

        // *Awal StokSum
        StokSum dataStok = listStokSum.firstWhere(
          (element) => (element.outletAsal == eListOutlet.id &&
              element.mataUang == eListCurrency.ctNama),
          orElse: () => StokSum(
            outletAsal: eListOutlet.id,
            mataUang: eListCurrency.ctNama,
            jumlah: '0',
            nilai: '0',
          ),
        );

        listAllStokSum.add(
          StokSum(
            outletAsal: eListOutlet.id,
            mataUang: eListCurrency.ctNama,
            jumlah: dataStok.jumlah,
            nilai: dataStok.nilai,
          ),
        );
        // *Akhir StokSum

      }
      // *Akhir melisting seluruh currency

    }
    // *Akhir melisting seluruh outlet

    int grandTotalIdr = 0;
    int grandTotalUsd = 0;
    int grandTotalEur = 0;
    int grandTotalSgd = 0;

    // *Untuk melisting seluruh outlet ke Model DataSum dan TotalSum agar pola sesuai UI
    for (var eListOutlet in authController.listOutlet) {
      String outletIdData = '';
      String outletNameData = '';

      String saldoIdrData = '';
      String saldoUsdData = '';
      String saldoEurData = '';
      String saldoSgdData = '';

      String stokIdrData = '';
      String stokUsdData = '';
      String stokEurData = '';
      String stokSgdData = '';

      outletIdData = eListOutlet.id;
      outletNameData = eListOutlet.outletName;

      // *Data Saldo
      for (var elistAllSaldoSum in listAllSaldoSum) {
        if (eListOutlet.id == elistAllSaldoSum.outletAsal) {
          if (elistAllSaldoSum.mataUang == 'IDR') {
            saldoIdrData =
                '${int.parse(elistAllSaldoSum.debet) - int.parse(elistAllSaldoSum.kredit)}';
          } else if (elistAllSaldoSum.mataUang == 'USD') {
            saldoUsdData =
                '${int.parse(elistAllSaldoSum.debet) - int.parse(elistAllSaldoSum.kredit)}';
          } else if (elistAllSaldoSum.mataUang == 'SGD') {
            saldoSgdData =
                '${int.parse(elistAllSaldoSum.debet) - int.parse(elistAllSaldoSum.kredit)}';
          } else if (elistAllSaldoSum.mataUang == 'EUR') {
            saldoEurData =
                '${int.parse(elistAllSaldoSum.debet) - int.parse(elistAllSaldoSum.kredit)}';
          }
        }
      }
      // *Data Saldo

      // *Data Stok
      for (var elistAllStokSum in listAllStokSum) {
        if (eListOutlet.id == elistAllStokSum.outletAsal) {
          if (elistAllStokSum.mataUang == 'IDR') {
            stokIdrData = '${int.parse(elistAllStokSum.nilai)}';
          } else if (elistAllStokSum.mataUang == 'USD') {
            stokUsdData = '${int.parse(elistAllStokSum.nilai)}';
          } else if (elistAllStokSum.mataUang == 'SGD') {
            stokSgdData = '${int.parse(elistAllStokSum.nilai)}';
          } else if (elistAllStokSum.mataUang == 'EUR') {
            stokEurData = '${int.parse(elistAllStokSum.nilai)}';
          }
        }
      }
      // *Data Stok

      _listDataSum.add(
        DataSum(
            outletId: outletIdData,
            outletName: outletNameData,
            saldoIdr: saldoIdrData,
            saldoUsd: saldoUsdData,
            saldoEur: saldoEurData,
            saldoSgd: saldoSgdData,
            stokIdr: stokIdrData,
            stokUsd: stokUsdData,
            stokEur: stokEurData,
            stokSgd: stokSgdData),
      );

      _listTotalSum.add(TotalSum(
        outletId: outletIdData,
        outletName: outletNameData,
        totalIdr: '${int.parse(saldoIdrData) + int.parse(stokIdrData)}',
        totalUsd: '${int.parse(saldoUsdData) + int.parse(stokUsdData)}',
        totalEur: '${int.parse(saldoEurData) + int.parse(stokEurData)}',
        totalSgd: '${int.parse(saldoSgdData) + int.parse(stokSgdData)}',
      ));

      grandTotalIdr += int.parse(saldoIdrData) + int.parse(stokIdrData);
      grandTotalUsd += int.parse(saldoUsdData) + int.parse(stokUsdData);
      grandTotalEur += int.parse(saldoEurData) + int.parse(stokEurData);
      grandTotalSgd += int.parse(saldoSgdData) + int.parse(stokSgdData);
    }
    // *Akhir dari melisting seluruh outlet ke Model DataSum dan TotalSum agar pola sesuai UI

    _grandTotalSum = TotalSum(
        outletId: '99',
        outletName: 'TOTAL',
        totalIdr: '$grandTotalIdr',
        totalUsd: '$grandTotalUsd',
        totalEur: '$grandTotalEur',
        totalSgd: '$grandTotalSgd');

    // print(
    //     '${_listDataSum[0].outletName} ${_listDataSum[0].saldoIdr} ${_listDataSum[0].stokIdr}');

    // return _listDataSum;
  }
  // *Akhir getSaldoStokSum()
}
