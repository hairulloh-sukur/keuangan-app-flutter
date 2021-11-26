// ignore_for_file: avoid_print,, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/currency_model.dart';
import '../models/outlet_model.dart';

class AuthController extends GetxController {
  final apiKeuangan = urlKeuangan + 'API/';

  var isAuth = false.obs; // ?true, jika user berhasil login

  var userId = ''.obs;
  var userRole = ''.obs;
  var userOutletId = ''.obs;

  List listOutlet = [].obs;
  List listCurrency = [].obs;
  var myCookie = ''.obs;

  // * Init Data
  Future<void> initData() async {
    Uri url = Uri.parse(apiKeuangan + 'Auth/initData');

    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.Request('GET', url);
      request.body = json.encode({
        "act": "initData",
        "outlet_id": 1,
        "user_id": 1,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Init Data');

        listOutlet = [];
        listCurrency = [];

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


        // *List Outlet untuk Induk
        listOutlet.add(
          Outlet(
            id: data['data']['outlet']['id'],
            outletName:
                data['data']['outlet']['outlet_name'].toString().toUpperCase(),
          ),
        );

        // *List Outlet untuk SubOutlet
        data['data']['outlet_subs'].map((e) {
          listOutlet.add(
            Outlet(
              id: e['id'],
              outletName: e['outlet_name'].toString().toUpperCase(),
            ),
          );
        }).toList();

        // *List Currency
        data['data']['cur_tipe'].map((e) {
          listCurrency.add(Currency(
              ctId: e['ct_id'],
              ctNama: e['ct_nama'],
              ctLogo: e['ct_logo'],
              ctKet: e['ct_ket']));
        }).toList();

      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  // *Login
  Future<void> login(
      {required String userName, required String password}) async {
    Uri url = Uri.parse(apiKeuangan + 'Auth');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request('POST', url);

      request.body = json.encode({
        "act": "LOGIN",
        "un": userName,
        "up": password,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('-> Login');
        var rawCookie = response.headers['set-cookie'];

        if (rawCookie != null) {
          int index = rawCookie.indexOf(';');
          myCookie.value =
              (index == -1) ? rawCookie : rawCookie.substring(0, index);
          // print(myCookie);
        }

        var responseData = await response.stream.bytesToString();

        var data = json.decode(responseData);

        if (data['status']['error'] == 0) {
          print('Login -> Success');

          isAuth.value = true;

          userId.value = data['data']['user']['user_id'];
          userRole.value = data['data']['user']['role'];
          userOutletId.value = data['data']['user']['outlet_id'];

          // print('$userId $userRole $userOutletId');
        } else if (data['status']['error'] == 1) {
          isAuth.value = false;

          Get.snackbar(
            "error",
            "Server Maintenance!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.amber[50],
            borderWidth: 1,
            borderColor: Colors.amber,
            margin: EdgeInsets.all(15),
          );
        } else {
          isAuth.value = false;

          Get.snackbar(
            "error",
            data['status']['err-info'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.amber[50],
            borderWidth: 1,
            borderColor: Colors.amber,
            margin: EdgeInsets.all(15),
          );
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
}
