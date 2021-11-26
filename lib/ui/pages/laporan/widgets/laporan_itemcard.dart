// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class LaporanItemCard extends StatefulWidget {
  String outletId;
  String outletName;
  String totalIdr;
  String totalUsd;
  String totalEur;
  String totalSgd;

  LaporanItemCard(
      {required this.outletId,
      required this.outletName,
      required this.totalIdr,
      required this.totalUsd,
      required this.totalEur,
      required this.totalSgd});

  @override
  State<LaporanItemCard> createState() => _LaporanItemCardState();
}

class _LaporanItemCardState extends State<LaporanItemCard> {
  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFEF4DB),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 3.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.outletName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'TOTAL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
                      width: pWidth * 0.48,
                      child: DottedLine(
                        dashLength: 5,
                        dashColor: Colors.greenAccent,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.totalIdr,
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
                      width: pWidth * 0.48,
                      child: DottedLine(
                        dashLength: 5,
                        dashColor: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.totalUsd,
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
                      width: pWidth * 0.48,
                      child: DottedLine(
                        dashLength: 5,
                        dashColor: Colors.amberAccent,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.totalEur,
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
                      width: pWidth * 0.48,
                      child: DottedLine(
                        dashLength: 5,
                        dashColor: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.totalSgd,
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
    );
  }
}
