// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, avoid_print, unused_field, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './widgets/stok_barang_itemcard.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/trx_get_controller.dart';
import '../../../models/outlet_model.dart';
import '../../../models/stok_get_model.dart';

class StokBarangPage extends StatefulWidget {
  // const StokBarangPage({Key? key}) : super(key: key);

  @override
  State<StokBarangPage> createState() => _StokBarangPageState();
}

class _StokBarangPageState extends State<StokBarangPage> {
  String outletId = Get.parameters['outletId'].toString();

  // *Nilai dari parameter Navigasi
  // String pOutletId = Get.parameters['outletId'].toString();
  String pOutletName = Get.parameters['outletName'].toString();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    // *Stok Get
    final trxController = Get.find<TrxGetController>();

    List<Outlet> dataListOutlet = [...authController.listOutlet];

    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'STOK BARANG',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            // color: Colors.amber,
            padding: EdgeInsets.fromLTRB(100, 0, 100, 15),

            // *DropdownSearch Outlet
            child: DropdownSearch<Outlet>(
              enabled: authController.userRole.value == 'Admin' ? true : false,
              items: dataListOutlet,
              dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Pilih Outlet...',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                filled: true,
                fillColor: Color(0xFFFEF4DB),
              ),
              popupItemBuilder: (context, item, isSelected) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    '${item.outletName}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              },
              itemAsString: (item) => item!.outletName,
              onChanged: (value) {
                print(value!.id); // *Id Outlet
                // pOutletId = value.id;
                outletId = value.id;
                pOutletName = value.outletName;

                setState(() {});
              },
              selectedItem: Outlet(id: outletId, outletName: pOutletName),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: trxController.stokGet(
          act: 'getStok',
          outletId: '1',
          userId: authController.userId.value,
          outletId1: outletId == '' ? '0' : outletId,
          status: '1',
        ),
        builder: (context, snapshot) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
            itemCount: trxController.listAllStokGet.length,
            itemBuilder: (context, index) {
              if (snapshot.connectionState == ConnectionState.done) {
                StokGet data = trxController.listAllStokGet[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: StokBarangItemCard(
                      trxPtipeNama: data.trxPtipeNama,
                      trxCurtipeVar: data.trxCurtipeVar,
                      trxAsalOutletNama: data.trxAsalOutletNama,
                      trxDarikeOutletId: data.trxDarikeOutletId,
                      trxDarikeOutletNama: data.trxDarikeOutletNama,
                      stokId: data.stokId,
                      trxId: data.trxId,
                      trxTgl: data.trxTgl,
                      trxPtipe: data.trxPtipe,
                      trxDateCreated: data.trxDateCreated,
                      trxNominal: data.trxNominal,
                      trxKet: data.trxKet,
                      trxAsalOutletId: data.trxAsalOutletId,
                      trxOutletId: data.trxOutletId),
                );
              } else {
                return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
