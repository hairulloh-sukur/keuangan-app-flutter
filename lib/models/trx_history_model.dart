// {
//     "outlet_id": "21",
//     "outlet_name": "Agam",
//     "trx_tgl": "2021-11-08",
//     "trx_ket": "dapet dari boss",
//     "masuk_idr":  "2200000000",
//     "masuk_usd":  "0",
//     "masuk_eur":  "0",
//     "masuk_sgd":  "0"
//     "keluar_idr":  "0",
//     "keluar_usd":  "0",
//     "keluar_eur":  "0",
//     "keluar_sgd":  "0"
// }

class TrxHistory {
  TrxHistory({
    required this.outletId,
    required this.outletName,
    required this.trxTgl,
    required this.trxKet,
    required this.masukIdr,
    required this.masukUsd,
    required this.masukEur,
    required this.masukSgd,
    required this.keluarIdr,
    required this.keluarUsd,
    required this.keluarEur,
    required this.keluarSgd,
  });

  String outletId;
  String outletName;

  String trxTgl;
  String trxKet;

  String masukIdr;
  String masukUsd;
  String masukEur;
  String masukSgd;

  String keluarIdr;
  String keluarUsd;
  String keluarEur;
  String keluarSgd;
}
