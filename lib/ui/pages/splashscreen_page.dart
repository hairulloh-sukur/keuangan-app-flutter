// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan_app/constants.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/stok_controller.dart';
import '../../controllers/trx_add_controller.dart';
import '../../controllers/trx_get_controller.dart';

import '../../routes/route_name.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getThingsOnStartup().then((_) => Get.offNamed(RouteName.loginPage));
  }

  Future _getThingsOnStartup() async {
    // print('Things To do');

    final authController = Get.put(AuthController());
    authController.initData();

    Get.put(HomeController());
    Get.put(TrxGetController());
    Get.put(TrxAddController());
    Get.put(StokController());

    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    // double pWidth = MediaQuery.of(context).size.width;
    double pHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: pHeight * 0.3),
              child: Image(
                height: 175,
                image: AssetImage(
                    'assets/images/splashscreen/Logo Splash Screen.png'),
              ),
            ),
            Text(
              'Versi $appVersion',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                (urlKeuangan == 'http://s.jtindonesia.com/alamr/public/')
                    ? ''
                    : 'Development',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
