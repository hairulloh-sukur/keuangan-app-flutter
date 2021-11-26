// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/constants.dart';
import 'package:keuangan_app/controllers/auth_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../controllers/trx_add_controller.dart';

class KonfirmasiItemCard extends StatefulWidget {
  String trxPtipeNama;
  String trxCurtipeVar;
  String trxAsalOutletNama;
  String trxDarikeOutletId;
  String trxDarikeOutletNama;
  String trxId;
  String trxTgl;
  String trxPtipe;
  String trxDateCreated;
  String trxNominal;
  String trxKet;
  String trxStatus;
  String trxIsStok;
  String trxAsalOutletId;
  String trxOutletId;

  KonfirmasiItemCard({
    required this.trxPtipeNama,
    required this.trxCurtipeVar,
    required this.trxAsalOutletNama,
    required this.trxDarikeOutletId,
    required this.trxDarikeOutletNama,
    required this.trxId,
    required this.trxTgl,
    required this.trxPtipe,
    required this.trxDateCreated,
    required this.trxNominal,
    required this.trxKet,
    required this.trxStatus,
    required this.trxIsStok,
    required this.trxAsalOutletId,
    required this.trxOutletId,
  });

  @override
  State<KonfirmasiItemCard> createState() => _KonfirmasiItemCardState();
}

class _KonfirmasiItemCardState extends State<KonfirmasiItemCard> {
  bool isExpanded = false;
  bool isHideButton = false;

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;

    final trxController = Get.find<TrxAddController>();

    final authController = Get.find<AuthController>();

    String imagePath = urlKeuangan +
        'data-photo/' +
        widget.trxTgl.substring(0, 10).replaceAll('-', '/') +
        '/' +
        widget.trxId +
        '.jpg';

    // print(imagePath);

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isExpanded ? 190 : 80,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.trxPtipeNama == 'Keluar'
              ? Colors.blue[50]
              : Color(0xFFFEF4DB),
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
                // *Nama Outlet
                Text(
                  widget.trxAsalOutletNama.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // *Tgl Trx
                SizedBox(
                  width: 110,
                  child: Text(
                    widget.trxDateCreated,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // *Tipe Transaksi
                SizedBox(
                  width: 100,
                  child: Text(
                    widget.trxPtipeNama.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // *Nominal Transaksi
                Text(
                  widget.trxCurtipeVar +
                      '. ' +
                      NumberFormat.decimalPattern()
                          .format(int.parse(widget.trxNominal))
                          .toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailScreen(imagePath: imagePath);
                    }));
                  },

                  // *Foto Transaksi
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[50] // Color(0xFFFFE4B8),
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imagePath,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.no_photography),
                      ),
                    ),
                  ),
                ),
                // *Keterangan Transaksi
                Container(
                  height: 60,
                  width: pWidth * 0.60,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                    children: [
                      Text(widget.trxKet),
                    ],
                  ),
                ),
              ],
            ),
            (isHideButton == false && authController.userRole.value == 'Admin')
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // *Trx Id
                      Expanded(
                        child: Text(
                          '(Trx.Id: ${widget.trxId})',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          trxController.trxApprove(trxId: widget.trxId);

                          setState(() {
                            isHideButton = !isHideButton;
                          });

                          // print("Confirm");
                        },
                        icon: Icon(
                          Icons.add_task,
                          size: 22,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text(
                                  'Apakah Transaksi ini yakin untuk dicancel?'),
                              actions: [
                                TextButton(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('Ya, dicancel'),
                                  onPressed: () {
                                    trxController.trxCancel(
                                        trxId: widget.trxId);

                                    setState(() {
                                      isHideButton = !isHideButton;
                                    });

                                    Get.back();
                                    print("Cancel");
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          size: 22,
                        ),
                      ),
                    ],
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // const DetailScreen({Key? key}) : super(key: key);

  String imagePath = '';

  DetailScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          child: PhotoView(
            imageProvider: NetworkImage(imagePath),
          ),
        ),
      ),
    );
  }
}
