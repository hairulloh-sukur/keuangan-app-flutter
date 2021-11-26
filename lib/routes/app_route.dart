// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:keuangan_app/ui/pages/detail_transaksi/detail_transaksi_page.dart';
import './route_name.dart';
import '../ui/menu_bar.dart';
import '../ui/pages/login/login_page.dart';
import '../ui/pages/trx_add/keluar_page.dart';
import '../ui/pages/trx_add/pindah_kurs_page.dart';
import '../ui/pages/trx_add/pindah_outlet_page.dart';
import '../ui/pages/stok_barang/stok_barang_page.dart';
import '../ui/pages/trx_add/masuk_page.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.menuBar,
      page: () => MenuBar(),
    ),
    GetPage(
      name: RouteName.masukPage + '/:outletId/:outletName',
      page: () => MasukPage(),
    ),
    GetPage(
      name: RouteName.keluarPage + '/:outletId/:outletName',
      page: () => KeluarPage(),
    ),
    GetPage(
      name: RouteName.pindahOutletPage + '/:outletId/:outletName',
      page: () => PindahOutletPage(),
    ),
    GetPage(
      name: RouteName.pindahKursPage + '/:outletId/:outletName',
      page: () => PindahKursPage(),
    ),
    GetPage(
      name: RouteName.stokBarangPage + '/:outletId/:outletName',
      page: () => StokBarangPage(),
    ),
    GetPage(
      name: RouteName.detailTransaksiPage + '/:outletId/:outletName',
      page: () => DetailTransaksiPage(),
    ),
  ];
}
