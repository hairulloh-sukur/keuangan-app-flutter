// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, unnecessary_string_interpolations

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/api/pdf_api.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/trx_get_controller.dart';
import '../../../models/outlet_model.dart';

class LaporanHistoryPage extends StatefulWidget {
  const LaporanHistoryPage({Key? key}) : super(key: key);

  @override
  State<LaporanHistoryPage> createState() => _LaporanHistoryPageState();
}

class _LaporanHistoryPageState extends State<LaporanHistoryPage> {
  String tglMulai = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String tglAkhir = DateFormat('yyyy-MM-dd').format(DateTime.now());

  var tanggalMulai = DateFormat.yMMMMd().format(DateTime.now()).obs;
  var tanggalAkhir = DateFormat.yMMMMd().format(DateTime.now()).obs;

  @override
  Widget build(BuildContext context) {
    double pHeight = MediaQuery.of(context).size.height;
    double pWidth = MediaQuery.of(context).size.width;

    final authController = Get.find<AuthController>();

    String outletId = authController.userOutletId.value;

    Outlet userOutlet = authController.listOutlet
        .firstWhere((element) => element.id == outletId);

    String outletName = userOutlet.outletName.toString().toUpperCase();

    List<Outlet> dataListOutlet = [...authController.listOutlet];

    // *Trx Get History
    final trxController = Get.find<TrxGetController>();

    return Stack(
      children: [
        Container(
          width: pWidth,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
          padding: EdgeInsets.symmetric(vertical: 25),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85),
                child: DropdownSearch<Outlet>(
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
                    outletId = value.id;
                    outletName = value.outletName;

                    // setState(() {});
                  },
                  selectedItem: Outlet(id: outletId, outletName: outletName),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Periode',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
              ),
              SizedBox(height: 20),
              Text(
                'dari tanggal:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              // *Tanggal Mulai
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          theme: DatePickerTheme(
                            headerColor: Color(0xFFFEF4DB),
                            backgroundColor: Colors.white,
                          ),
                          onChanged: (date) {}, onConfirm: (date) {
                        tglMulai = DateFormat('yyyy-MM-dd').format(date);

                        tanggalMulai.value = DateFormat.yMMMMd().format(date);
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    icon: Icon(Icons.event),
                  ),
                  Obx(() => Text(tanggalMulai.value)),
                ],
              ),
              Text(
                'sampai tanggal:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              // *Tanggal Akhir
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          theme: DatePickerTheme(
                            headerColor: Color(0xFFFEF4DB),
                            backgroundColor: Colors.white,
                          ),
                          onChanged: (date) {}, onConfirm: (date) {
                        tglAkhir = DateFormat('yyyy-MM-dd').format(date);

                        tanggalAkhir.value = DateFormat.yMMMMd().format(date);
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    icon: Icon(Icons.event),
                  ),
                  Obx(() => Text(tanggalAkhir.value)),
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
                onPressed: () async {
                  await trxController
                      .trxGetHistory(
                          act: 'getTrxHistory',
                          outletId: '1',
                          userId: authController.userId.value,
                          outletId1: outletId,
                          userId1: '0',
                          trxPtipe: '0',
                          trxPayTipe: '0',
                          rptJenis: '',
                          dateStart: tglMulai,
                          dateEnd: tglAkhir,
                          outletName: outletName)
                      .then((_) async {
                    final pdfFile = await PdfApi.generateReport(
                        outletName: outletName,
                        tglMulai: tglMulai,
                        tglAkhir: tglAkhir);

                    await Future.delayed(Duration(milliseconds: 500));

                    // PdfApi.openFile(pdfFile);
                    await PdfApi.openFile(pdfFile);
                  });
                },
              ),
            ],
          ),
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
                    onTap: () {},
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
            ],
          ),
        ),
      ],
    );
  }
}
