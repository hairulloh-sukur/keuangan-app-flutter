// {
//     "trx_ptipe_nama": "Masuk",
//     "trx_curtipe_var": "S$",
//     "trx_asal_outlet_nama": "BUSCO",
//     "trx_darike_outlet_id": "0",
//     "trx_darike_outlet_nama": "",
//     "trx_id": "38",
//     "trx_tgl": "2021-11-05",
//     "trx_ptipe": "1",
//     "trx_date_created": "2021-11-05 16:29:16",
//     "trx_nominal": "1000",
//     "trx_ket": "tes",
//     "trx_status": "1",
//     "trx_is_stok": "0",
//     "trx_asal_outlet_id": "6",
//     "trx_outlet_id": "1"
// },

// To parse this JSON data, do
//
//     final trxGet = trxGetFromJson(jsonString);

import 'dart:convert';

TrxGet trxGetFromJson(String str) => TrxGet.fromJson(json.decode(str));

String trxGetToJson(TrxGet data) => json.encode(data.toJson());

class TrxGet {
  TrxGet({
    required this.trxPtipeNama,
    required this.trxCurtipeVar,
    required this.trxAsalOutletNama,
    required this.trxDarikeOutletId,
    required this.trxDarikeOutletNama,
    required this.trxId,
    required this.trxTgl,
    required this.trxPtipe,
    required this.trxDateCreated,
    required this.trxNominal,
    required this.trxKet,
    required this.trxStatus,
    required this.trxIsStok,
    required this.trxAsalOutletId,
    required this.trxOutletId,
  });

  String trxPtipeNama;
  String trxCurtipeVar;
  String trxAsalOutletNama;
  String trxDarikeOutletId;
  String trxDarikeOutletNama;
  String trxId;
  String trxTgl;
  String trxPtipe;
  String trxDateCreated;
  String trxNominal;
  String trxKet;
  String trxStatus;
  String trxIsStok;
  String trxAsalOutletId;
  String trxOutletId;

  factory TrxGet.fromJson(Map<String, dynamic> json) => TrxGet(
        trxPtipeNama: json["trx_ptipe_nama"],
        trxCurtipeVar: json["trx_curtipe_var"],
        trxAsalOutletNama: json["trx_asal_outlet_nama"],
        trxDarikeOutletId: json["trx_darike_outlet_id"],
        trxDarikeOutletNama: json["trx_darike_outlet_nama"],
        trxId: json["trx_id"],
        trxTgl: json["trx_tgl"],
        trxPtipe: json["trx_ptipe"],
        trxDateCreated: json["trx_date_created"],
        trxNominal: json["trx_nominal"],
        trxKet: json["trx_ket"],
        trxStatus: json["trx_status"],
        trxIsStok: json["trx_is_stok"],
        trxAsalOutletId: json["trx_asal_outlet_id"],
        trxOutletId: json["trx_outlet_id"],
      );

  Map<String, dynamic> toJson() => {
        "trx_ptipe_nama": trxPtipeNama,
        "trx_curtipe_var": trxCurtipeVar,
        "trx_asal_outlet_nama": trxAsalOutletNama,
        "trx_darike_outlet_id": trxDarikeOutletId,
        "trx_darike_outlet_nama": trxDarikeOutletNama,
        "trx_id": trxId,
        "trx_tgl": trxTgl,
        "trx_ptipe": trxPtipe,
        "trx_date_created": trxDateCreated,
        "trx_nominal": trxNominal,
        "trx_ket": trxKet,
        "trx_status": trxStatus,
        "trx_is_stok": trxIsStok,
        "trx_asal_outlet_id": trxAsalOutletId,
        "trx_outlet_id": trxOutletId,
      };

  static List<TrxGet> fromJsonList(List list) {
    if (list.isEmpty) return List<TrxGet>.empty();
    return list.map((item) => TrxGet.fromJson(item)).toList();
  }
}
