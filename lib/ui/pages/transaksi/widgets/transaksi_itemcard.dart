// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/constants.dart';
import 'package:photo_view/photo_view.dart';

class TransaksiItemCard extends StatefulWidget {
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

  TransaksiItemCard({
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
  State<TransaksiItemCard> createState() => _TransaksiItemCardState();
}

class _TransaksiItemCardState extends State<TransaksiItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;

    String imagePath = urlKeuangan + 'data-photo/' +
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
        height: isExpanded ? 180 : 80,
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
            SizedBox(height: 10),
            // *Trx Id
            Text(
              '(Trx.Id: ${widget.trxId})',
              style: TextStyle(color: Colors.grey),
            ),
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
