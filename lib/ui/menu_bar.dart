// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan_app/controllers/trx_get_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/pages/splashscreen_page.dart';
import '../ui/pages/home/home_page.dart' as home;
import '../ui/pages/transaksi/transaksi_page.dart' as transaksi;
import '../ui/pages/konfirmasi/konfirmasi_page.dart' as konfirmasi;
import '../ui/pages/laporan/laporan_page.dart' as summary;
import '../ui/pages/laporan_history/laporan_history_page.dart' as laporan;

class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 5);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // *Trx Get - Pending
    final trxController = Get.find<TrxGetController>();

    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      appBar: AppBar(
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                tabController.animateTo(2);
              },
              icon: (trxController.totalTrxPending.value > 0)
                  ? Image(
                      height: 40,
                      image: AssetImage(
                          'assets/images/transaksi/lonceng-notifikasi.gif'),
                    )
                  : Icon(Icons.notifications_none),
            );
          }),
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('Konfirmasi'),
                  content: Text('Apakah aplikasi ingin dilogout?'),
                  actions: [
                    TextButton(
                      child: Text('Tidak'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: Text('Ya, dilogout'),
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();

                        pref.setBool('isAutoLogin', false);

                        Get.offAll(SplashScreenPage());
                      },
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'KEUANGAN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            // color: Colors.indigo,
            padding: EdgeInsets.only(bottom: 10),
            height: 75,
            child: TabBar(
              controller: tabController,
              padding: EdgeInsets.symmetric(horizontal: 20),
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              labelPadding: EdgeInsets.only(bottom: 2),
              indicatorColor: Color(0xFFFFE4B8),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  icon: Image(
                    height: 40,
                    image: AssetImage('assets/images/homepage/Icon Home.png'),
                  ),
                  text: 'HOME',
                ),
                Tab(
                  icon: Image(
                    height: 40,
                    image:
                        AssetImage('assets/images/homepage/Icon Transaksi.png'),
                  ),
                  text: 'TRANSAKSI',
                ),
                Tab(
                  icon: Image(
                    height: 40,
                    image: AssetImage(
                        'assets/images/homepage/Icon Konfirmasi.png'),
                  ),
                  text: "KONFIRMASI",
                ),
                Tab(
                  icon: Image(
                    height: 40,
                    image:
                        AssetImage('assets/images/homepage/Icon Summary.png'),
                  ),
                  text: "SUMMARY",
                ),
                Tab(
                  icon: Image(
                    height: 40,
                    image:
                        AssetImage('assets/images/homepage/Icon Laporan.png'),
                  ),
                  text: "LAPORAN",
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          home.HomePage(),
          transaksi.TransaksiPage(),
          konfirmasi.KonfirmasiPage(),
          summary.LaporanPage(), // *Jadi Summary
          laporan.LaporanHistoryPage()
        ],
      ),
    );
  }
}
