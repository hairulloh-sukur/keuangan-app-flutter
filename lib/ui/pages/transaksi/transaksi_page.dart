// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan_app/controllers/auth_controller.dart';
import 'package:keuangan_app/models/outlet_model.dart';
import 'package:keuangan_app/routes/route_name.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import './widgets/transaksi_itemcard.dart';
import '../../../controllers/trx_get_controller.dart';
import '../../../models/trx_get_model.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key? key}) : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  double target = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapHandler() {
    target += 0.45;
    if (target > 1.0) {
      target = 0.45;
      _animationController.reset();
    }
    _animationController.animateTo(target);

    setState(() {
      TransaksiPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    double pHeight = MediaQuery.of(context).size.height;

    final authController = Get.find<AuthController>();

    String userOutletId = authController.userOutletId.value;

    Outlet userOutlet = authController.listOutlet
        .firstWhere((element) => element.id == userOutletId);

    String userOutletName = userOutlet.outletName.toString().toUpperCase();

    // *Trx Get - Approved
    final trxController = Get.find<TrxGetController>();

    return Stack(
      children: [
        FutureBuilder(
          future: trxController.trxGet(
              act: 'getNewTrx',
              outletId: '1',
              userId: authController.userId.value,
              trxId: '0',
              outletId1: authController.userOutletId.value == '1'
                  ? '0'
                  : authController.userOutletId.value,
              status: '1',
              dateStart: '',
              dateEnd: ''),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
              itemCount: trxController.listAllTrxGet.length,
              itemBuilder: (context, index) {
                if (snapshot.connectionState == ConnectionState.done) {
                  TrxGet data = trxController.listAllTrxGet[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TransaksiItemCard(
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
                    onTap: _onTapHandler,
                    child: RotationTransition(
                      turns: Tween(begin: 3.0, end: 0.0)
                          .animate(_animationController),
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
              ),
            ],
          ),
        ),

        // *FloatingButton Menu Add, Edit, Delete

        Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: SpeedDial(
              child: Image.asset(
                'assets/images/transaksi/Icon Menu.png',
                height: 40,
              ),
              speedDialChildren: <SpeedDialChild>[
                SpeedDialChild(
                  child: Image.asset(
                    'assets/images/homepage/Icon Masuk.png',
                    height: 30,
                  ),
                  backgroundColor: Color(0xFFD9FFCE),
                  label: 'Masuk',
                  onPressed: () {
                    Get.toNamed(
                        RouteName.masukPage + '/$userOutletId/$userOutletName');
                  },
                ),
                SpeedDialChild(
                  child: Image.asset(
                    'assets/images/homepage/Icon Keluar.png',
                    height: 30,
                  ),
                  backgroundColor: Color(0xFFD9FFCE),
                  label: 'Keluar',
                  onPressed: () {
                    Get.toNamed(RouteName.keluarPage +
                        '/$userOutletId/$userOutletName');
                  },
                ),
                // SpeedDialChild(
                //   child: Image.asset(
                //     'assets/images/homepage/Icon Pindah.png',
                //     height: 30,
                //   ),
                //   backgroundColor: Color(0xFFD9FFCE),
                //   label: 'Pindah',
                //   onPressed: () {
                //     Get.toNamed(RouteName.pindahOutletPage + '/1/INDUK');
                //   },
                // ),
              ],
              closedBackgroundColor: Color(0xFFD9FFCE),
              openBackgroundColor: Color(0xFFFEF4DB),
            ),
          ),
        ),
      ],
    );
  }
}
