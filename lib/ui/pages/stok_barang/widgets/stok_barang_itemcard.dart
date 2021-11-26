// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/constants.dart';
import 'package:keuangan_app/controllers/auth_controller.dart';
import 'package:keuangan_app/controllers/stok_controller.dart';
import 'package:photo_view/photo_view.dart';

class StokBarangItemCard extends StatefulWidget {
  String trxPtipeNama;
  String trxCurtipeVar;
  String trxAsalOutletNama;
  String trxDarikeOutletId;
  String trxDarikeOutletNama;
  String stokId;
  String trxId;
  String trxTgl;
  String trxPtipe;
  String trxDateCreated;
  String trxNominal;
  String trxKet;
  String trxAsalOutletId;
  String trxOutletId;

  StokBarangItemCard({
    required this.trxPtipeNama,
    required this.trxCurtipeVar,
    required this.trxAsalOutletNama,
    required this.trxDarikeOutletId,
    required this.trxDarikeOutletNama,
    required this.stokId,
    required this.trxId,
    required this.trxTgl,
    required this.trxPtipe,
    required this.trxDateCreated,
    required this.trxNominal,
    required this.trxKet,
    required this.trxAsalOutletId,
    required this.trxOutletId,
  });

  @override
  State<StokBarangItemCard> createState() => _StokBarangItemCardState();
}

class _StokBarangItemCardState extends State<StokBarangItemCard> {
  bool isExpanded = false;
  bool isHideButton = false;

  String act = '';
  String outletId = '1';
  String userId = '';
  String stokId = '';
  String jualHarga = '';
  String currId = '';

  final TextEditingController nominalController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;

    final authController = Get.find<AuthController>();
    userId = authController.userId.value;

    final stokController = Get.find<StokController>();

    String imagePath = urlKeuangan +
        'data-photo/' +
        widget.trxTgl.substring(0, 10).replaceAll('-', '/') +
        '/' +
        widget.trxId +
        '.jpg';

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isExpanded ? 195 : 90,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue[50],
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
                // *Foto Transaksi
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailScreen(imagePath: imagePath);
                    }));
                  },
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
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
                          indent: 4,
                          endIndent: 4,
                          thickness: 1.5,
                        ),
                        // *Nominal Transaksi
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // *Keterangan Transaksi
                SizedBox(
                  height: 60,
                  width: pWidth * 0.81,
                  child: ListView(
                    children: [
                      Text(widget.trxKet),
                    ],
                  ),
                ),
              ],
            ),
            (isHideButton == false)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // *Trx Id
                      Expanded(
                        child: Text(
                          '(Trx.Id: ${widget.trxId}, Stok.Id: ${widget.stokId} )',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      // *Jual
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Form(
                                key: _formKey,
                                child: SizedBox(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Text(
                                          'Apakah Stok ini yakin untuk dijual? \n(Harga Beli ${widget.trxCurtipeVar + '. ' + NumberFormat.decimalPattern().format(int.parse(widget.trxNominal)).toString()}), \nJual ${widget.trxCurtipeVar}.'),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 15, 5, 0),
                                        child: TextFormField(
                                          controller: nominalController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Nominal',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Mohon masukkan nominal';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            nominalController
                                              ..text = NumberFormat("#,###")
                                                  .format(int.parse(value))
                                              ..selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset:
                                                              nominalController
                                                                  .text
                                                                  .length));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('Ya, dijual'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      jualHarga = nominalController.text
                                          .replaceAll(',', '');
                                      stokId = widget.stokId;

                                      if (widget.trxCurtipeVar == 'Rp') {
                                        currId = '1';
                                      } else if (widget.trxCurtipeVar == '\$') {
                                        currId = '2';
                                      } else if (widget.trxCurtipeVar ==
                                          'S\$') {
                                        currId = '3';
                                      } else if (widget.trxCurtipeVar == '€') {
                                        currId = '4';
                                      }

                                      stokController.stokJual(
                                          act: 'stokJual',
                                          outletId: outletId,
                                          userId: userId,
                                          stokId: stokId,
                                          jualHarga: jualHarga,
                                          currId: currId);

                                      setState(() {
                                        isHideButton = !isHideButton;
                                      });

                                      Get.back();
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.local_grocery_store,
                          size: 22,
                        ),
                      ),
                      // *Hapus
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('Konfirmasi'),
                              content:
                                  Text('Apakah Stok ini yakin untuk dihapus?'),
                              actions: [
                                TextButton(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('Ya, hapus'),
                                  onPressed: () {
                                    stokId = widget.stokId;

                                    stokController.stokHapus(
                                        act: 'stokHapus',
                                        outletId: outletId,
                                        userId: userId,
                                        stokId: stokId,
                                        ket: 'Stok dihapus');

                                    setState(() {
                                      isHideButton = !isHideButton;
                                    });

                                    Get.back();
                                    print("Jual");
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
