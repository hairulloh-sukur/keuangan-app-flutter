// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './widgets/laporan_itemcard.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/total_sum_model.dart';
import '../../../routes/route_name.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage>
    with TickerProviderStateMixin {
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
      LaporanPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    double pHeight = MediaQuery.of(context).size.height;
    double pWidth = MediaQuery.of(context).size.width;

    final authController = Get.find<AuthController>();

    final homeController = Get.find<HomeController>();

    TotalSum dataTotal = homeController.grandTotalSum;

    return Stack(
      children: [
        FutureBuilder(
          future: homeController.getSaldoStokSum(
              userId: authController.userId.value,
              outletId: authController.userOutletId.value),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
              itemCount: homeController.listTotalSum.length,
              itemBuilder: (context, index) {
                TotalSum data = homeController.listTotalSum[index];
                if (snapshot.connectionState == ConnectionState.done) {
                  if (authController.userOutletId.value == '1' ||
                      authController.userOutletId.value == data.outletId) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.detailTransaksiPage +
                            '/${data.outletId}/${data.outletName.toString()}');
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: LaporanItemCard(
                          outletId: data.outletId,
                          outletName: data.outletName.toString(),
                          totalIdr: NumberFormat.decimalPattern()
                              .format(int.parse(data.totalIdr))
                              .toString(),
                          totalUsd: NumberFormat.decimalPattern()
                              .format(int.parse(data.totalUsd))
                              .toString(),
                          totalEur: NumberFormat.decimalPattern()
                              .format(int.parse(data.totalEur))
                              .toString(),
                          totalSgd: NumberFormat.decimalPattern()
                              .format(int.parse(data.totalSgd))
                              .toString(),
                        ),
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

        // ListView(
        //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        //   children: [
        //     // *Card 1
        //     LaporanItemCard(),
        //     SizedBox(height: 20),

        //   ],
        // ),

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

        // *Floating Button TOTAL
        authController.userRole.value == 'Admin' &&
                authController.userOutletId.value == '1'
            ? Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue[50],
                    child: Icon(
                      Icons.functions,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            height: 150,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'TOTAL',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    indent: 5,
                                    endIndent: 5,
                                    thickness: 1.5,
                                  ),
                                  SizedBox(height: 10),

                                  // *Detail Currency
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // *IDR
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: pWidth * 0.076,
                                              child: Text(
                                                'IDR',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: pWidth * 0.37,
                                              child: DottedLine(
                                                dashLength: 5,
                                                dashColor: Colors.greenAccent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                NumberFormat.decimalPattern()
                                                    .format(int.parse(
                                                        dataTotal.totalIdr))
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        // *USD
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: pWidth * 0.076,
                                              child: Text(
                                                'USD',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: pWidth * 0.37,
                                              child: DottedLine(
                                                dashLength: 5,
                                                dashColor: Colors.blueAccent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                NumberFormat.decimalPattern()
                                                    .format(int.parse(
                                                        dataTotal.totalUsd))
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        // *EUR
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: pWidth * 0.076,
                                              child: Text(
                                                'EUR',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: pWidth * 0.37,
                                              child: DottedLine(
                                                dashLength: 5,
                                                dashColor: Colors.amberAccent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                NumberFormat.decimalPattern()
                                                    .format(int.parse(
                                                        dataTotal.totalEur))
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        // *SGD
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: pWidth * 0.076,
                                              child: Text(
                                                'SGD',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: pWidth * 0.37,
                                              child: DottedLine(
                                                dashLength: 5,
                                                dashColor: Colors.redAccent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                NumberFormat.decimalPattern()
                                                    .format(int.parse(
                                                        dataTotal.totalSgd))
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    // color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
