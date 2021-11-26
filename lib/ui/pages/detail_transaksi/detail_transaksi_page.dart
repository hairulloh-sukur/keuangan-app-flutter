// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, avoid_print, unused_field, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/models/trx_get_model.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/trx_get_controller.dart';
import '../../../models/outlet_model.dart';
import './widgets/detail_transaksi_itemcard.dart';

class DetailTransaksiPage extends StatefulWidget {
  // const DetailTransaksiPage({Key? key}) : super(key: key);

  @override
  State<DetailTransaksiPage> createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
  String tglMulai = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String tglAkhir = DateFormat('yyyy-MM-dd').format(DateTime.now());

  var tanggalMulai = DateFormat.yMMMMd().format(DateTime.now()).obs;
  var tanggalAkhir = DateFormat.yMMMMd().format(DateTime.now()).obs;

  String outletId = Get.parameters['outletId'].toString();

  // *Nilai dari parameter Navigasi
  String pOutletName = Get.parameters['outletName'].toString();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    // *Trx Get - Approved
    final trxController = Get.find<TrxGetController>();

    List<Outlet> dataListOutlet = [...authController.listOutlet];

    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'DETAIL TRANSAKSI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            padding: EdgeInsets.fromLTRB(100, 0, 100, 15),

            // *DropdownSearch Outlet
            child: Column(
              children: [
                DropdownSearch<Outlet>(
                  enabled:
                      authController.userRole.value == 'Admin' ? true : false,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: trxController.trxGet(
            act: 'getNewTrx',
            outletId: '1',
            userId: authController.userId.value,
            trxId: '0',
            outletId1: outletId == '' ? '0' : outletId,
            status: '1',
            dateStart: tglMulai,
            dateEnd: tglAkhir),
        builder: (context, snapshot) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
            itemCount: trxController.listAllTrxGet.length,
            itemBuilder: (context, index) {
              if (snapshot.connectionState == ConnectionState.done) {
                TrxGet data = trxController.listAllTrxGet[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: DetailTransaksiItemCard(
                      trxPtipeNama: data.trxPtipeNama,
                      trxCurtipeVar: data.trxCurtipeVar,
                      trxAsalOutletNama: data.trxAsalOutletNama,
                      trxDarikeOutletId: data.trxDarikeOutletId,
                      trxDarikeOutletNama: data.trxDarikeOutletNama,
                      trxId: data.trxId,
                      trxTgl: data.trxTgl,
                      trxPtipe: data.trxPtipe,
                      trxDateCreated: data.trxDateCreated,
                      trxNominal: data.trxNominal,
                      trxKet: data.trxKet,
                      trxStatus: data.trxStatus,
                      trxIsStok: data.trxIsStok,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFEF4DB),
        child: Image.asset(
          'assets/images/transaksi/Icon Menu.png',
          height: 40,
        ),
        onPressed: () {
          showModalBottomSheet<void>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                // padding: EdgeInsets.symmetric(horizontal: 50),
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Periode',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'dari tanggal:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              // *Tanggal Mulai
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          theme: DatePickerTheme(
                                            headerColor: Color(0xFFFEF4DB),
                                            backgroundColor: Colors.white,
                                          ),
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        tglMulai = DateFormat('yyyy-MM-dd')
                                            .format(date);

                                        tanggalMulai.value =
                                            DateFormat.yMMMMd().format(date);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.id);
                                    },
                                    icon: Icon(Icons.event),
                                  ),
                                  Obx(() => Text(tanggalMulai.value)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'sampai tanggal:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // *Tanggal Akhir
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          theme: DatePickerTheme(
                                            headerColor: Color(0xFFFEF4DB),
                                            backgroundColor: Colors.white,
                                          ),
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        tglAkhir = DateFormat('yyyy-MM-dd')
                                            .format(date);

                                        tanggalAkhir.value =
                                            DateFormat.yMMMMd().format(date);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.id);
                                    },
                                    icon: Icon(Icons.event),
                                  ),
                                  Obx(() => Text(tanggalAkhir.value)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text('PROSES'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFEF4DB),
                          onPrimary: Colors.black,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
