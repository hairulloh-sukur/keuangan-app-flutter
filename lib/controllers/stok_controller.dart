// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import './auth_controller.dart';
import '../constants.dart';

class StokController extends GetxController {
  final apiKeuangan = urlKeuangan + 'API/';

  final authController = Get.find<AuthController>();

  Future<void> stokJual(
      {required String act,
      required String outletId,
      required String userId,
      required String stokId,
      required String jualHarga,
      required String currId}) async {
    // *Url Jual Stok
    Uri url = Uri.parse(apiKeuangan + 'Trx/StokJual');

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
          "stok_id": int.parse(stokId),
          "jual_harga": int.parse(jualHarga),
          "curr_id": int.parse(currId)
        }
      });
      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Stok Jual');

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
          "Sukses dijual",
          // "Transaksi Sukses",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[50],
          borderWidth: 1,
          borderColor: Colors.blue,
          margin: EdgeInsets.all(15),
        );
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

  Future<void> stokHapus({
    required String act,
    required String outletId,
    required String userId,
    required String stokId,
    required String ket,
  }) async {
    // *Url Hapus Stok
    Uri url = Uri.parse(apiKeuangan + 'Trx/HapusStok');

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
        "data1": {"stok_id": int.parse(stokId), "ket": ket}
      });
      request.headers.addAll(headers);

      // print(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Stok Hapus');

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
          "Stok Berhasil dihapus",
          // "Transaksi Sukses",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[50],
          borderWidth: 1,
          borderColor: Colors.blue,
          margin: EdgeInsets.all(15),
        );
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
}
