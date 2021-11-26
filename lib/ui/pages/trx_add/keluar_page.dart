// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, avoid_print, unused_field, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/trx_add_controller.dart';
import '../../../models/outlet_model.dart';

class KeluarPage extends StatefulWidget {
  // const KeluarPage({Key? key}) : super(key: key);

  @override
  State<KeluarPage> createState() => _KeluarPageState();
}

class _KeluarPageState extends State<KeluarPage> {
  String valMataUang = '';
  String tanggalKeluar = DateFormat.yMMMMd().format(DateTime.now());

  var _image;
  var imagePicker;

  String act = '';
  String outletId = '1';
  String userId = '';
  String pTipe = '2';
  String pTipeKeluar = '';
  String currId = '';
  String nominal = '';
  String ket = '';
  var photo;
  String outletId1 = Get.parameters['outletId'].toString();
  String outletId2 = '0';
  String tgl = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // *Nilai dari parameter Navigasi
  // String pOutletId = Get.parameters['outletId'].toString();
  String pOutletName = Get.parameters['outletName'].toString();

  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
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
          'KELUAR',
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
              DropdownSearch<String>(
                mode: Mode.MENU,
                dropdownSearchDecoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Pilih Tipe Keluar...',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                showSelectedItems: true,
                items: [
                  'OPERASIONAL',
                  'STOK',
                ],
                onChanged: (value) {
                  print(value);
                  pTipeKeluar = value.toString();
                },
              ),
              SizedBox(height: 20),

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
                          tanggalKeluar = DateFormat.yMMMMd().format(date);
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    icon: Icon(Icons.event),
                  ),
                  Text(tanggalKeluar),
                ],
              ),

              DottedLine(
                dashLength: 5,
                dashColor: Colors.black,
              ),
              SizedBox(height: 20),
              Text(
                'Mata Uang',
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
                          groupValue: valMataUang,
                          onChanged: (value) {
                            currId = value.toString();

                            setState(() {
                              valMataUang = value.toString();
                              print(valMataUang);
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
                          groupValue: valMataUang,
                          onChanged: (value) {
                            currId = value.toString();

                            setState(() {
                              valMataUang = value.toString();
                              print(valMataUang);
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
                          groupValue: valMataUang,
                          onChanged: (value) {
                            currId = value.toString();

                            setState(() {
                              valMataUang = value.toString();
                              print(valMataUang);
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
                          groupValue: valMataUang,
                          onChanged: (value) {
                            currId = value.toString();

                            setState(() {
                              valMataUang = value.toString();
                              print(valMataUang);
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
              DottedLine(
                dashLength: 5,
                dashColor: Colors.black,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: nominalController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nominal',
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
                      return 'Mohon masukkan nominal';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nominalController
                      ..text = NumberFormat("#,###").format(int.parse(value))
                      ..selection = TextSelection.fromPosition(
                          TextPosition(offset: nominalController.text.length));
                  },
                ),
              ),
              SizedBox(height: 20),
              DottedLine(
                dashLength: 5,
                dashColor: Colors.black,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(20),
                  padding: EdgeInsets.all(5),
                  dashPattern: [6, 3, 2, 3],
                  color: Colors.grey.withOpacity(0.5),
                  strokeWidth: 1,
                  child: GestureDetector(
                    onTap: myAlert,
                    child: Container(
                      height: 125,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: _image != null
                          ? Image.file(
                              _image,
                              // width: 200.0,
                              // height: 200.0,
                              fit: BoxFit.fitHeight,
                            )
                          : SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 50,
                                    image: AssetImage(
                                        'assets/images/proses/Icon CAM.png'),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Tambahkan Foto',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: keteranganController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Keterangan',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan keterangan';
                    }
                    return null;
                  },
                ),
              ),

              // *Tombol Tambah
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: ElevatedButton(
                  child: Text('TAMBAH'),
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
                      nominal = nominalController.text.replaceAll(',', '');
                      ket = keteranganController.text;

                      if (pTipeKeluar == 'OPERASIONAL') {
                        act = 'addNewTrx';
                      } else if (pTipeKeluar == 'STOK') {
                        act = 'addNewStok';
                      }

                      // print('outletId1: $outletId1 tipe keluar: $pTipeKeluar');

                      // print(
                      //     'act: $act - outletId: $outletId - userId: $userId - pTipe: $pTipe - currId: $currId - nominal: $nominal - ket: $ket - outletId: $outletId - tgl: $tgl');

                      if (outletId1 != '' &&
                          pTipeKeluar != '' &&
                          tgl != '' &&
                          currId != '') {
                        trxController.trxAdd(
                            act: act,
                            outletId: outletId,
                            userId: userId,
                            pTipe: pTipe,
                            currId: currId,
                            nominal: nominal,
                            ket: ket,
                            photo: photo,
                            outletId1: outletId1,
                            outletId2: outletId2,
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

  Future getImage(ImageSource media) async {
    try {
      XFile image = await imagePicker.pickImage(
        source: media,
        imageQuality: 10,
      );
      setState(() {
        _image = File(image.path);
        photo = _image;
      });
    } catch (e) {
      print(e);
    }
  }

  void myAlert() {
    print(_image);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Silahkan pilih media:'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        SizedBox(width: 5),
                        Text('Dari Gallery'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        SizedBox(width: 5),
                        Text('Dari Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
