// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/controllers/auth_controller.dart';
import 'package:keuangan_app/controllers/trx_get_controller.dart';
import './widgets/outlet_itemcard.dart';
import '../../../models/data_sum_model.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  double target = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapHandler() {
    target += 0.45;
    if (target > 1.0) {
      target = 0.45;
      _animationController.reset();
    }
    _animationController.animateTo(target);

    setState(() {
      HomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    // double pWidth = MediaQuery.of(context).size.width;
    double pHeight = MediaQuery.of(context).size.height;

    final authController = Get.find<AuthController>();

    final homeController = Get.find<HomeController>();

    // *Trx Get - Pending
    final trxController = Get.find<TrxGetController>();

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

    return Stack(
      children: [
        FutureBuilder(
          future: homeController.getSaldoStokSum(
              userId: authController.userId.value,
              outletId: authController.userOutletId.value),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
              itemCount: homeController.listDataSum.length,
              itemBuilder: (context, index) {
                DataSum data = homeController.listDataSum[index];
                if (snapshot.connectionState == ConnectionState.done) {
                  if (authController.userOutletId.value == '1' ||
                      authController.userOutletId.value == data.outletId) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: OutletItemCard(
                        outletId: data.outletId,
                        outletName: data.outletName.toString(),
                        saldoIdr: NumberFormat.decimalPattern()
                            .format(int.parse(data.saldoIdr))
                            .toString(),
                        saldoUsd: NumberFormat.decimalPattern()
                            .format(int.parse(data.saldoUsd))
                            .toString(),
                        saldoEur: NumberFormat.decimalPattern()
                            .format(int.parse(data.saldoEur))
                            .toString(),
                        saldoSgd: NumberFormat.decimalPattern()
                            .format(int.parse(data.saldoSgd))
                            .toString(),
                        stokIdr: NumberFormat.decimalPattern()
                            .format(int.parse(data.stokIdr))
                            .toString(),
                        stokUsd: NumberFormat.decimalPattern()
                            .format(int.parse(data.stokUsd))
                            .toString(),
                        stokEur: NumberFormat.decimalPattern()
                            .format(int.parse(data.stokEur))
                            .toString(),
                        stokSgd: NumberFormat.decimalPattern()
                            .format(int.parse(data.stokSgd))
                            .toString(),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              },
            );
          },
        ),

        // *Bar Refresh
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: pHeight * 0.065,
                decoration: BoxDecoration(
                  // color: Colors.amber.withOpacity(0.2),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/homepage/Bar Refresh.png',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: _onTapHandler,
                    child: RotationTransition(
                      turns: Tween(begin: 3.0, end: 0.0)
                          .animate(_animationController),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          // color: Colors.cyanAccent.withOpacity(0.2),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/homepage/Icon Refresh.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
