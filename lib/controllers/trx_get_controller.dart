// ignore_for_file: avoid_print,, prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:keuangan_app/constants.dart';
import 'package:keuangan_app/models/trx_get_history_model.dart';
import 'package:keuangan_app/models/trx_get_sum_history_model.dart';
import 'package:keuangan_app/models/trx_history_model.dart';
import '../models/stok_get_model.dart';
import './auth_controller.dart';
import '../models/trx_get_model.dart';

// * Controller Untuk Get Trx dan Stok
class TrxGetController extends GetxController {
  final apiKeuangan = urlKeuangan + 'API/';

  final authController = Get.find<AuthController>();

  List<TrxGet> _listAllTrxGet = [];
  List<TrxGet> get listAllTrxGet => _listAllTrxGet.obs;

  // *Trx Get History
  List<TrxGetHistory> _listAllTrxGetHistory = [];

  // *Trx History untuk data report
  List<TrxHistory> _listTrxHistory = [];
  List<TrxHistory> get listTrxHistory => _listTrxHistory.obs;

  // *Trx Get Sum History
  List<TrxGetSumHistory> _listAllTrxGetSumHistory = [];

  // *Sum History
  var totalMasukIdr = '0'.obs;
  var totalKeluarIdr = '0'.obs;
  var totalMasukUsd = '0'.obs;
  var totalKeluarUsd = '0'.obs;
  var totalMasukSgd = '0'.obs;
  var totalKeluarSgd = '0'.obs;
  var totalMasukEur = '0'.obs;
  var totalKeluarEur = '0'.obs;

  // * Jumlah Trx Pending
  var totalTrxPending = 0.obs;

  List<StokGet> _listAllStokGet = [];
  List<StokGet> get listAllStokGet => _listAllStokGet.obs;

  // * Trx Get (Trx Pending dan Approved)
  Future trxGet(
      {required String act,
      required String outletId,
      required String userId,
      required String trxId,
      required String outletId1,
      required String status,
      required String dateStart,
      required String dateEnd}) async {
    // *Url Get
    Uri url = Uri.parse(apiKeuangan + 'Trx/Get');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };

      var request = http.Request('POST', url);
      request.body = json.encode({
        "act": act,
        "outlet_id": int.parse(outletId),
        "user_id": int.parse(userId),
        "data1": {
          "trx_id": int.parse(trxId),
          "outlet_id1": int.parse(outletId1),
          "status": int.parse(status),
          "date_start": dateStart,
          "date_end": dateEnd
        }
      });
      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      _listAllTrxGet = [];

      if (status == '0') {
        totalTrxPending.value = 0;
      }

      if (response.statusCode == 200) {
        print('-> Trx Get');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData) as Map<String, dynamic>;

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

        var results = data["data"] as List<dynamic>;

        _listAllTrxGet = TrxGet.fromJsonList(results);

        if (status == '0') {
          totalTrxPending.value = _listAllTrxGet.length;
        }
      } else {
        print(response.reasonPhrase);

        Get.snackbar(
          "Perhatian",
          "${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber[50],
          borderWidth: 1,
          borderColor: Colors.amber,
          margin: EdgeInsets.all(15),
        );
      }
      return _listAllTrxGet;
    } catch (e) {
      print(e);
    }
  }

  // * Stok Get (Stok Approved)
  // {"act":"getStok","outlet_id":1,"user_id":1,"data1":{"outlet_id1":0,"status":1}}
  Future stokGet({
    required String act,
    required String outletId,
    required String userId,
    required String outletId1,
    required String status,
  }) async {
    // *Url GetStok
    Uri url = Uri.parse(apiKeuangan + 'Trx/GetStok');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };

      var request = http.Request('GET', url);
      request.body = json.encode({
        "act": "getStok",
        "outlet_id": int.parse(outletId),
        "user_id": int.parse(userId),
        "data1": {"outlet_id1": int.parse(outletId1), "status": 1}
      });

      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      _listAllStokGet = [];
      if (response.statusCode == 200) {
        print('-> Stok Get');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData) as Map<String, dynamic>;

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

        var results = data["data"] as List<dynamic>;

        _listAllStokGet = StokGet.fromJsonList(results);
      } else {
        print(response.reasonPhrase);

        Get.snackbar(
          "Perhatian",
          "${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber[50],
          borderWidth: 1,
          borderColor: Colors.amber,
          margin: EdgeInsets.all(15),
        );
      }
      return _listAllStokGet;
    } catch (e) {
      print(e);
    }
  }

  // * Trx Get History
  Future trxGetHistory(
      {required String act,
      required String outletId,
      required String userId,
      required String outletId1,
      required String userId1,
      required String trxPtipe,
      required String trxPayTipe,
      required String rptJenis,
      required String dateStart,
      required String dateEnd,
      required String outletName}) async {
    // *Url Get History
    Uri url = Uri.parse(apiKeuangan + 'Report/Get');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };

      var request = http.Request('GET', url);
      request.body = json.encode({
        "act": act,
        "outlet_id": int.parse(outletId),
        "user_id": int.parse(userId),
        "data1": {
          "outlet_id1": int.parse(outletId1),
          "user_id1": int.parse(userId1),
          "trx_ptipe": int.parse(trxPtipe),
          "trx_pay_tipe": int.parse(trxPayTipe),
          "rpt_jenis": rptJenis,
          "date_start": dateStart,
          "date_end": dateEnd
        }
      });

      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      _listAllTrxGetHistory = [];
      _listTrxHistory = [];

      _listAllTrxGetSumHistory = [];

      if (response.statusCode == 200) {
        print('-> Trx Get History');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData) as Map<String, dynamic>;

        // print(data);

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

        if (data["data"]["hasil"] != null) {
          var results = data["data"]["hasil"] as List<dynamic>;
          var sumResults = data["data"]["sum"] as List<dynamic>;

          _listAllTrxGetHistory = TrxGetHistory.fromJsonList(results);
          _listAllTrxGetSumHistory = TrxGetSumHistory.fromJsonList(sumResults);
        }

        for (var eListAllTrxGetHistory in _listAllTrxGetHistory) {
          String trxOutletId = '';
          String trxOutletName = '';

          String trxTgl = '';
          String trxKet = '';

          String trxMasukIdr = '';
          String trxMasukUsd = '';
          String trxMasukEur = '';
          String trxMasukSgd = '';

          String trxKeluarIdr = '';
          String trxKeluarUsd = '';
          String trxKeluarEur = '';
          String trxKeluarSgd = '';

          trxOutletId = outletId;
          trxOutletName = outletName;
          trxTgl = eListAllTrxGetHistory.trxTgl;
          trxKet = eListAllTrxGetHistory.trxKet;

          // *Trx Masuk
          if (eListAllTrxGetHistory.ptipeNama == 'Masuk') {
            // *IDR
            if (eListAllTrxGetHistory.trxCurTipe == '1') {
              trxMasukIdr = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
            // *USD
            else if (eListAllTrxGetHistory.trxCurTipe == '2') {
              trxMasukUsd = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
            // *SGD
            else if (eListAllTrxGetHistory.trxCurTipe == '3') {
              trxMasukSgd = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
            // *EUR
            else if (eListAllTrxGetHistory.trxCurTipe == '4') {
              trxMasukEur = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
          }
          // *Trx Keluar
          else if (eListAllTrxGetHistory.ptipeNama == 'Keluar') {
            // *IDR
            if (eListAllTrxGetHistory.trxCurTipe == '1') {
              trxKeluarIdr = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
            // *USD
            else if (eListAllTrxGetHistory.trxCurTipe == '2') {
              trxKeluarUsd = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
            // *SGD
            else if (eListAllTrxGetHistory.trxCurTipe == '3') {
              trxKeluarSgd = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
            // *EUR
            else if (eListAllTrxGetHistory.trxCurTipe == '4') {
              trxKeluarEur = NumberFormat.decimalPattern()
                  .format(int.parse(eListAllTrxGetHistory.trxNominal))
                  .toString();
            }
          }

          _listTrxHistory.add(TrxHistory(
              outletId: trxOutletId,
              outletName: trxOutletName,
              trxTgl: trxTgl,
              trxKet: trxKet,
              masukIdr: trxMasukIdr,
              masukUsd: trxMasukUsd,
              masukEur: trxMasukEur,
              masukSgd: trxMasukSgd,
              keluarIdr: trxKeluarIdr,
              keluarUsd: trxKeluarUsd,
              keluarEur: trxKeluarEur,
              keluarSgd: trxKeluarSgd));
        }

        // *Sum History
        totalMasukIdr.value = '0';
        totalKeluarIdr.value = '0';
        totalMasukUsd.value = '0';
        totalKeluarUsd.value = '0';
        totalMasukSgd.value = '0';
        totalKeluarSgd.value = '0';
        totalMasukEur.value = '0';
        totalKeluarEur.value = '0';

        for (var eListAllTrxGetSumHistory in _listAllTrxGetSumHistory) {
          // *IDR
          if (eListAllTrxGetSumHistory.mataUang == 'IDR') {
            totalMasukIdr.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.debet))
                .toString();

            totalKeluarIdr.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.kredit))
                .toString();
          }
          // *USD
          else if (eListAllTrxGetSumHistory.mataUang == 'USD') {
            totalMasukUsd.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.debet))
                .toString();

            totalKeluarUsd.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.kredit))
                .toString();
          }
          // *SGD
          else if (eListAllTrxGetSumHistory.mataUang == 'SGD') {
            totalMasukSgd.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.debet))
                .toString();

            totalKeluarSgd.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.kredit))
                .toString();
          }
          // *EUR
          else if (eListAllTrxGetSumHistory.mataUang == 'EUR') {
            totalMasukEur.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.debet))
                .toString();

            totalKeluarEur.value = NumberFormat.decimalPattern()
                .format(int.parse(eListAllTrxGetSumHistory.kredit))
                .toString();
          }
        }

        // print(_listTrxHistory[1].trxKet);
      } else {
        print(response.reasonPhrase);

        Get.snackbar(
          "Perhatian",
          "${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber[50],
          borderWidth: 1,
          borderColor: Colors.amber,
          margin: EdgeInsets.all(15),
        );
      }
      return _listAllTrxGetHistory;
    } catch (e) {
      print(e);
    }
  }
}
