// {
//     "outlet_id": "21",
//     "outlet_name": "Agam",
//     "saldo_idr":  "2200000000",
//     "saldo_usd":  "0",
//     "saldo_eur":  "0",
//     "saldo_sgd":  "0"
//     "stok_idr":  "500000",
//     "stok_usd":  "0",
//     "stok_eur":  "0",
//     "stok_sgd":  "0"
// }

class DataSum {
  DataSum({
    required this.outletId,
    required this.outletName,
    required this.saldoIdr,
    required this.saldoUsd,
    required this.saldoEur,
    required this.saldoSgd,
    required this.stokIdr,
    required this.stokUsd,
    required this.stokEur,
    required this.stokSgd,
  });

  String outletId;
  String outletName;

  String saldoIdr;
  String saldoUsd;
  String saldoEur;
  String saldoSgd;

  String stokIdr;
  String stokUsd;
  String stokEur;
  String stokSgd;
}
