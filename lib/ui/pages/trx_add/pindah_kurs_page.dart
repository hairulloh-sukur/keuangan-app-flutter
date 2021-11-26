// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, avoid_print, unused_field, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/trx_add_controller.dart';
import '../../../models/outlet_model.dart';

class PindahKursPage extends StatefulWidget {
  // const PindahKursPage({Key? key}) : super(key: key);

  @override
  State<PindahKursPage> createState() => _PindahKursPageState();
}

class _PindahKursPageState extends State<PindahKursPage> {
  String valMataUangAsal = '';
  String valMataUangTujuan = '';

  String tanggalPindah = DateFormat.yMMMMd().format(DateTime.now());

  String act = 'trxTukarKurs';

  String outletId = '1';
  String userId = '';
  String ptipe = '4';

// *Asal
  String outletId1 = Get.parameters['outletId'].toString();
  String trxCurr1 = '';
  String trxNom1 = '';

// *Tujuan
  String outletId2 = Get.parameters['outletId'].toString();
  String trxCurr2 = '';
  String trxNom2 = '';

  String tgl = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // *Nilai dari parameter Navigasi
  // String pOutletId = Get.parameters['outletId'].toString();
  String pOutletName = Get.parameters['outletName'].toString();

  final TextEditingController nominalAsalController = TextEditingController();

  final TextEditingController nominalKursController = TextEditingController();
  final TextEditingController nominalKonversiController =
      TextEditingController();

  final TextEditingController nominalTujuanController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    userId = authController.userId.value;

    final trxController = Get.find<TrxAddController>();

    List<Outlet> dataListOutlet = [...authController.listOutlet];

    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'PINDAH KURS',
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
                outletId1 = value.id;
                outletId2 = value.id;
                pOutletName = value.outletName;
              },
              selectedItem: Outlet(id: outletId1, outletName: pOutletName),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(45, 20, 45, 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // *Pilih Tanggal
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
                        tgl = DateFormat('yyyy-MM-dd').format(date);
                        print(DateFormat('yyyy-MM-dd')
                            .format(date)); // * nilai tanggal
                        setState(() {
                          tanggalPindah = DateFormat.yMMMMd().format(date);
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    icon: Icon(Icons.event),
                  ),
                  Text(tanggalPindah),
                ],
              ),

              // SizedBox(height: 20),
              DottedLine(
                dashLength: 5,
                dashColor: Colors.black,
              ),
              SizedBox(height: 20),

              // *Mata Uang Asal
              Text(
                'Mata Uang Asal:',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // *RadioButton IDR
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '1', // *'IDR'
                          groupValue: valMataUangAsal,
                          onChanged: (value) {
                            trxCurr1 = value.toString();
                            print(trxCurr1);

                            setState(() {
                              valMataUangAsal = value.toString();
                              print(valMataUangAsal);
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                        Text('IDR'),
                      ],
                    ),
                  ),

                  // *RadioButton USD
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '2', // *'USD'
                          groupValue: valMataUangAsal,
                          onChanged: (value) {
                            trxCurr1 = value.toString();
                            print(trxCurr1);

                            setState(() {
                              valMataUangAsal = value.toString();
                              print(valMataUangAsal);
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                        Text('USD'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // *RadioButton EUR
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '4', // *'EUR'
                          groupValue: valMataUangAsal,
                          onChanged: (value) {
                            trxCurr1 = value.toString();
                            print(trxCurr1);

                            setState(() {
                              valMataUangAsal = value.toString();
                              print(valMataUangAsal);
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                        Text('EUR'),
                      ],
                    ),
                  ),

                  // *RadioButton SGD
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '3', // *'SGD'
                          groupValue: valMataUangAsal,
                          onChanged: (value) {
                            trxCurr1 = value.toString();
                            print(trxCurr1);

                            setState(() {
                              valMataUangAsal = value.toString();
                              print(valMataUangAsal);
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                        Text('SGD'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // *Nominal Asal
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: nominalAsalController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nominal Asal',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nominal asal';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nominalAsalController
                      ..text = NumberFormat("#,###").format(int.parse(value))
                      ..selection = TextSelection.fromPosition(TextPosition(
                          offset: nominalAsalController.text.length));
                  },
                ),
              ),
              SizedBox(height: 20),
              DottedLine(
                dashLength: 5,
                dashColor: Colors.black,
              ),
              SizedBox(height: 20),

              // *Mata Uang Tujuan
              Text(
                'Mata Uang Tujuan:',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // *RadioButton IDR
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '1', // *'IDR'
                          groupValue: valMataUangTujuan,
                          onChanged: (value) {
                            trxCurr2 = value.toString();
                            print(trxCurr2);

                            setState(() {
                              valMataUangTujuan = value.toString();
                              print(valMataUangTujuan);
                            });
                          },
                          activeColor: Colors.blueAccent,
                        ),
                        Text('IDR'),
                      ],
                    ),
                  ),

                  // *RadioButton USD
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '2', // *'USD'
                          groupValue: valMataUangTujuan,
                          onChanged: (value) {
                            trxCurr2 = value.toString();
                            print(trxCurr2);

                            setState(() {
                              valMataUangTujuan = value.toString();
                              print(valMataUangTujuan);
                            });
                          },
                          activeColor: Colors.blueAccent,
                        ),
                        Text('USD'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // *RadioButton EUR
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '4', // *'EUR'
                          groupValue: valMataUangTujuan,
                          onChanged: (value) {
                            trxCurr2 = value.toString();
                            print(trxCurr2);

                            setState(() {
                              valMataUangTujuan = value.toString();
                              print(valMataUangTujuan);
                            });
                          },
                          activeColor: Colors.blueAccent,
                        ),
                        Text('EUR'),
                      ],
                    ),
                  ),

                  // *RadioButton SGD
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: '3', // *'SGD'
                          groupValue: valMataUangTujuan,
                          onChanged: (value) {
                            trxCurr2 = value.toString();
                            print(trxCurr2);

                            setState(() {
                              valMataUangTujuan = value.toString();
                              print(valMataUangTujuan);
                            });
                          },
                          activeColor: Colors.blueAccent,
                        ),
                        Text('SGD'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text('Kalkulator:'),
                    SizedBox(height: 10),

                    // *Nilai Kurs
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: nominalKursController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nilai Kurs',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon masukkan nominal tujuan';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          var total;

                          if (trxCurr2 == '') {
                            Get.snackbar(
                              "Info",
                              "Mohon Mata Uang Tujuan dipilih terlebihdahulu",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.amber[50],
                              borderWidth: 1,
                              borderColor: Colors.amber,
                              margin: EdgeInsets.all(15),
                            );
                          }

                          if (((trxCurr1 == '4' && trxCurr2 != '4') ||
                                  ((trxCurr1 == '2' && trxCurr2 != '2') &&
                                      (trxCurr2 == '3' || trxCurr2 == '1')) ||
                                  ((trxCurr1 == '3' && trxCurr2 != '3') &&
                                      trxCurr2 == '1')) &&
                              trxCurr2 != '') {
                            total = int.parse(nominalAsalController.text
                                    .replaceAll(',', '')) *
                                int.parse(value);
                          } else if ((trxCurr1 == '1' && trxCurr2 != '1') &&
                              trxCurr2 != '') {
                            total = int.parse(nominalAsalController.text
                                    .replaceAll(',', '')) /
                                int.parse(value);
                          }

                          // print(total);

                          nominalKonversiController.text =
                              NumberFormat("#,###").format(total);

                          nominalTujuanController.text =
                              NumberFormat("#,###").format(total);

                          nominalKursController
                            ..text =
                                NumberFormat("#,###").format(int.parse(value))
                            ..selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: nominalKursController.text.length));
                        },
                      ),
                    ),
                    SizedBox(height: 10),

                    // *Nilai Konversi
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: nominalKonversiController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nilai Konversi',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        enabled: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon masukkan nominal tujuan';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          nominalKonversiController.text =
                              NumberFormat("#,###").format(int.parse(value));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // *Nominal Tujuan
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: nominalTujuanController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nominal Tujuan',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nominal tujuan';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nominalTujuanController
                      ..text = NumberFormat("#,###").format(int.parse(value))
                      ..selection = TextSelection.fromPosition(TextPosition(
                          offset: nominalTujuanController.text.length));
                  },
                ),
              ),
              SizedBox(height: 20),
              DottedLine(
                dashLength: 5,
                dashColor: Colors.black,
              ),
              SizedBox(height: 20),

              // *Tombol Pindah
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: ElevatedButton(
                  child: Text('PINDAH'),
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
                    if (_formKey.currentState!.validate()) {
                      trxNom1 = nominalAsalController.text.replaceAll(',', '');
                      trxNom2 =
                          nominalTujuanController.text.replaceAll(',', '');

                      if (outletId1 != '' &&
                          tgl != '' &&
                          trxCurr1 != '' &&
                          trxCurr2 != '' &&
                          trxNom1 != '' &&
                          trxNom2 != '') {
                        trxController.trxPindahKurs(
                            act: act,
                            outletId: outletId,
                            userId: userId,
                            ptipe: ptipe,
                            outletId1: outletId1,
                            trxCurr1: trxCurr1,
                            trxNom1: trxNom1,
                            outletId2: outletId2,
                            trxCurr2: trxCurr2,
                            trxNom2: trxNom2,
                            tgl: tgl);
                        Get.back();
                      } else {
                        Get.snackbar(
                          "Perhatian",
                          "Mohon lengkapi isian terlebihdahulu",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.amber[50],
                          borderWidth: 1,
                          borderColor: Colors.amber,
                          margin: EdgeInsets.all(15),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
