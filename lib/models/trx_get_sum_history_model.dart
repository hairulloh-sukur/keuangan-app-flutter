// {
//     "outlet_asal": "1",
//     "outlet_asal_nama": "Induk",
//     "jumlah": "5",
//     "mata_uang": "IDR",
//     "Debet": "20000000",
//     "Kredit": "15000000",
//     "Saldo": "5000000"
// }

// To parse this JSON data, do
//
//     final trxGetSumHistory = trxGetSumHistoryFromJson(jsonString);

import 'dart:convert';

TrxGetSumHistory trxGetSumHistoryFromJson(String str) =>
    TrxGetSumHistory.fromJson(json.decode(str));

String trxGetSumHistoryToJson(TrxGetSumHistory data) =>
    json.encode(data.toJson());

class TrxGetSumHistory {
  TrxGetSumHistory({
    required this.outletAsal,
    required this.outletAsalNama,
    required this.jumlah,
    required this.mataUang,
    required this.debet,
    required this.kredit,
    required this.saldo,
  });

  String outletAsal;
  String outletAsalNama;
  String jumlah;
  String mataUang;
  String debet;
  String kredit;
  String saldo;

  factory TrxGetSumHistory.fromJson(Map<String, dynamic> json) =>
      TrxGetSumHistory(
        outletAsal: json["outlet_asal"],
        outletAsalNama: json["outlet_asal_nama"],
        jumlah: json["jumlah"],
        mataUang: json["mata_uang"],
        debet: json["Debet"],
        kredit: json["Kredit"],
        saldo: json["Saldo"],
      );

  Map<String, dynamic> toJson() => {
        "outlet_asal": outletAsal,
        "outlet_asal_nama": outletAsalNama,
        "jumlah": jumlah,
        "mata_uang": mataUang,
        "Debet": debet,
        "Kredit": kredit,
        "Saldo": saldo,
      };

  static List<TrxGetSumHistory> fromJsonList(List list) {
    if (list.isEmpty) return List<TrxGetSumHistory>.empty();
    return list.map((item) => TrxGetSumHistory.fromJson(item)).toList();
  }
}
