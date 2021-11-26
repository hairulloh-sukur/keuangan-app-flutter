// ignore_for_file: avoid_print,, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:keuangan_app/controllers/trx_get_controller.dart';
import './auth_controller.dart';
import '../constants.dart';

class TrxAddController extends GetxController {
  final apiKeuangan = urlKeuangan + 'API/';

  final authController = Get.find<AuthController>();

  // *Trx Get - Pending
  final trxController = Get.find<TrxGetController>();

  // * Proses Trx Add
  Future<void> trxAdd(
      {required String act,
      required String outletId,
      required String userId,
      required String pTipe,
      required String currId,
      required String nominal,
      required String ket,
      required var photo,
      required String outletId1,
      required String outletId2,
      required String tgl}) async {
    // *Url Add

    // print(photo);

    Uri url = Uri.parse(apiKeuangan + 'Trx/Add');

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
          "ptipe": int.parse(pTipe),
          "curr_id": int.parse(currId),
          "nominal": nominal,
          "ket": ket,
          "photo": photo != null ? base64Encode(photo.readAsBytesSync()) : '',
          "outlet_id1": int.parse(outletId1),
          "outlet_id2": int.parse(outletId2),
          "tgl": tgl
        }
      });
      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Trx Add');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

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

        Get.snackbar(
          "Info",
          "Transaksi Sukses, Trx Id. ${data['data']['trx_id']}",
          // "Transaksi Sukses",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[50],
          borderWidth: 1,
          borderColor: Colors.blue,
          margin: EdgeInsets.all(15),
        );

        trxController.trxGet(
            act: 'getNewTrx',
            outletId: '1',
            userId: authController.userId.value,
            trxId: '0',
            outletId1: authController.userOutletId.value == '1'
                ? '0'
                : authController.userOutletId.value,
            status: '0',
            dateStart: '',
            dateEnd: '');
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
    } catch (e) {
      print(e);
    }
  }

  // * Proses Trx Approval
  Future<void> trxApprove({required String trxId}) async {
    // *Url Approve
    Uri url = Uri.parse(apiKeuangan + 'Trx/Approve');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };
      var request = http.Request('GET', url);
      request.body = json.encode({
        "act": "accNewTrx",
        "outlet_id": 1,
        "user_id": 1,
        "data1": {"trx_id": int.parse(trxId)}
      });
      request.headers.addAll(headers);

      print(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Trx Approve');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

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

        Get.snackbar(
          "Info",
          "Approval Sukses, Trx Id. ${data['data']['trx_id']}",
          // "Transaksi Sukses",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[50],
          borderWidth: 1,
          borderColor: Colors.blue,
          margin: EdgeInsets.all(15),
        );
      } else {
        // print(response.reasonPhrase);

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
    } catch (e) {
      print(e);
    }
  }

  // * Proses Pindah Kurs
  Future<void> trxPindahKurs({
    required String act,
    required String outletId,
    required String userId,
    required String ptipe,
    required String outletId1,
    required String trxCurr1,
    required String trxNom1,
    required String outletId2,
    required String trxCurr2,
    required String trxNom2,
    required String tgl,
  }) async {
    // *Url Pindah Kurs
    Uri url = Uri.parse(apiKeuangan + 'Trx/TukarKurs');

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
          "ptipe": int.parse(ptipe),
          "trx_curr_1": int.parse(trxCurr1),
          "trx_nom_1": int.parse(trxNom1),
          "outlet_id1": int.parse(outletId1),
          "trx_curr_2": int.parse(trxCurr2),
          "trx_nom_2": int.parse(trxNom2),
          "outlet_id2": int.parse(outletId2),
          "tgl": tgl
        }
      });
      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Trx Pindah Kurs');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

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

        Get.snackbar(
          "Info",
          "Pindah Kurs Sukses",
          // "Transaksi Sukses",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[50],
          borderWidth: 1,
          borderColor: Colors.blue,
          margin: EdgeInsets.all(15),
        );
      } else {
        // print(response.reasonPhrase);

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
    } catch (e) {
      print(e);
    }
  }

  // * Proses Trx Cancel
  Future<void> trxCancel({required String trxId}) async {
    // *Url Cancel
    Uri url = Uri.parse(apiKeuangan + 'Trx/CancelTrx');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': authController.myCookie.toString()
      };
      var request = http.Request('GET', url);
      request.body = json.encode({
        "act": "delNewTrx",
        "outlet_id": 1,
        "user_id": 1,
        "data1": {"trx_id": int.parse(trxId), "ket": "Trx Canceled"}
      });
      request.headers.addAll(headers);

      print(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Trx Canceled');

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

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

        Get.snackbar(
          "Info",
          "Transaksi dicancel, Trx Id. ${data['data']['trx_id']}",
          // "Transaksi Sukses",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[50],
          borderWidth: 1,
          borderColor: Colors.blue,
          margin: EdgeInsets.all(15),
        );
      } else {
        // print(response.reasonPhrase);

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
    } catch (e) {
      print(e);
    }
  }
}
