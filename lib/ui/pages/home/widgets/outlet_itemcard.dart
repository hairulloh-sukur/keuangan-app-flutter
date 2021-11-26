// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:keuangan_app/controllers/auth_controller.dart';
import '../../../../routes/route_name.dart';

class OutletItemCard extends StatefulWidget {
  String outletId;
  String outletName;

  String saldoIdr;
  String saldoUsd;
  String saldoEur;
  String saldoSgd;

  String stokIdr;
  String stokUsd;
  String stokEur;
  String stokSgd;

  OutletItemCard({
    required this.outletId,
    required this.outletName,
    required this.saldoIdr,
    required this.saldoUsd,
    required this.saldoEur,
    required this.saldoSgd,
    required this.stokIdr,
    required this.stokUsd,
    required this.stokEur,
    required this.stokSgd,
  });

  @override
  State<OutletItemCard> createState() => _OutletItemCardState();
}

class _OutletItemCardState extends State<OutletItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;

    final authController = Get.find<AuthController>();

    return Stack(
      children: [
        // *Card
        Container(
          height: 153,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 3.0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Row(
            children: [
              // *Detail Outlet
              Container(
                // color: Colors.redAccent.withOpacity(0.5),
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // *Nama Outlet
                    Text(
                      widget.outletName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),

                    // *Detail Currency
                    Container(
                      // color: Colors.green.withOpacity(0.5),
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                // width: 170,
                                width: pWidth * 0.40,
                                child: DottedLine(
                                  dashLength: 5,
                                  dashColor: Colors.greenAccent,
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  widget.saldoIdr,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 12,
                                      // color: Colors.grey,
                                      fontWeight: FontWeight.bold),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: pWidth * 0.40,
                                child: DottedLine(
                                  dashLength: 5,
                                  dashColor: Colors.blueAccent,
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  widget.saldoUsd,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 12,
                                      // color: Colors.grey,
                                      fontWeight: FontWeight.bold),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: pWidth * 0.40,
                                child: DottedLine(
                                  dashLength: 5,
                                  dashColor: Colors.amberAccent,
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  widget.saldoEur,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 12,
                                      // color: Colors.grey,
                                      fontWeight: FontWeight.bold),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: pWidth * 0.40,
                                child: DottedLine(
                                  dashLength: 5,
                                  dashColor: Colors.redAccent,
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  widget.saldoSgd,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 12,
                                      // color: Colors.grey,
                                      fontWeight: FontWeight.bold),
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
            ],
          ),
        ),

        // *Action
        SizedBox(
          height: 153,
          // color: Colors.blue.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // *Action Sliding Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: SizedBox(
                  width: 34,
                  // color: Colors.blue.withOpacity(0.2),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/homepage/Line Slide.png',
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              // color: Colors.cyanAccent.withOpacity(0.2),
                              image: DecorationImage(
                                image: AssetImage(
                                  isExpanded
                                      ? 'assets/images/homepage/Icon Close Slide.png'
                                      : 'assets/images/homepage/Icon Tambah.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // *Action Box
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: isExpanded ? 290 : 15, //15
                decoration: BoxDecoration(
                  color: Color(0xFFFEF4DB),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: isExpanded
                    ? Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  // *Action IconButton
                                  SizedBox(
                                    height: 60,
                                    width: 260,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // *Masuk
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Get.toNamed(RouteName
                                                          .masukPage +
                                                      '/${widget.outletId}/${widget.outletName}');
                                                },
                                                icon: Image(
                                                  height: 35,
                                                  image: AssetImage(
                                                      'assets/images/homepage/Icon Masuk.png'),
                                                ),
                                              ),
                                              Text(
                                                'MASUK',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // *Keluar
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Get.toNamed(RouteName
                                                          .keluarPage +
                                                      '/${widget.outletId}/${widget.outletName}');
                                                },
                                                icon: Image(
                                                  height: 35,
                                                  image: AssetImage(
                                                      'assets/images/homepage/Icon Keluar.png'),
                                                ),
                                              ),
                                              Text(
                                                'KELUAR',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // *Pindah Outlet
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if ((authController.userRole.value == 'Admin' && authController.userOutletId.value == '1') || (authController.userRole.value == 'Manager'))  {
                                                    Get.toNamed(RouteName
                                                            .pindahOutletPage +
                                                        '/${widget.outletId}/${widget.outletName}');
                                                  } else {
                                                    Get.snackbar(
                                                      "Perhatian",
                                                      "Transaksi Pindah Outlet hanya user dengan role Admin atau Manager",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                      backgroundColor:
                                                          Colors.amber[50],
                                                      borderWidth: 1,
                                                      borderColor: Colors.amber,
                                                      margin:
                                                          EdgeInsets.all(15),
                                                    );
                                                  }
                                                },
                                                icon: Image(
                                                  height: 35,
                                                  image: AssetImage(
                                                      'assets/images/homepage/Icon Pindah.png'),
                                                ),
                                              ),
                                              Text(
                                                'OUTLET',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // // *Mutasi
                                        // SizedBox(
                                        //   child: Column(
                                        //     children: [
                                        //       IconButton(
                                        //         onPressed: () {},
                                        //         icon: Image(
                                        //           height: 35,
                                        //           image: AssetImage(
                                        //               'assets/images/homepage/Icon Mutasi.png'),
                                        //         ),
                                        //       ),
                                        //       Text(
                                        //         'MUTASI',
                                        //         style: TextStyle(
                                        //             fontSize: 10,
                                        //             fontWeight:
                                        //                 FontWeight.bold),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),

                                        // *Pindah Kurs
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Get.toNamed(RouteName
                                                          .pindahKursPage +
                                                      '/${widget.outletId}/${widget.outletName}');
                                                },
                                                icon: Image(
                                                  height: 35,
                                                  image: AssetImage(
                                                      'assets/images/homepage/Icon Kurs.png'),
                                                ),
                                              ),
                                              Text(
                                                'KURS',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // *Detail Stok
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteName.stokBarangPage +
                                          '/${widget.outletId}/${widget.outletName}');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 8),
                                      height: 75,
                                      width: 260,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFE4B8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        // color: Colors.green.withOpacity(0.5),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 7, 10, 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'TOTAL STOK:',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  // color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5),

                                            // *IDR
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    'IDR',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  width: 150,
                                                  child: DottedLine(
                                                    dashLength: 5,
                                                    dashColor:
                                                        Colors.greenAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  // width: 90,
                                                  width: 70,
                                                  child: Text(
                                                    widget.stokIdr,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3),

                                            // *USD
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    'USD',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  width: 150,
                                                  child: DottedLine(
                                                    dashLength: 5,
                                                    dashColor:
                                                        Colors.blueAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                  child: Text(
                                                    widget.stokUsd,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3),

                                            // *EUR
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    'EUR',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  width: 150,
                                                  child: DottedLine(
                                                    dashLength: 5,
                                                    dashColor:
                                                        Colors.amberAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                  child: Text(
                                                    widget.stokEur,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3),

                                            // *SGD
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    'SGD',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        // color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  width: 150,
                                                  child: DottedLine(
                                                    dashLength: 5,
                                                    dashColor: Colors.redAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                  child: Text(
                                                    widget.stokSgd,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 8,
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
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
