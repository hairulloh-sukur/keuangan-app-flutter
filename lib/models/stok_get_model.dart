// {
//     "trx_ptipe_nama": "Keluar",
//     "trx_curtipe_var": "Rp",
//     "trx_asal_outlet_nama": "Induk",
//     "trx_darike_outlet_id": "0",
//     "trx_darike_outlet_nama": "",
//     "stok_id": "8",
//     "trx_id": "15",
//     "trx_tgl": "2021-11-04",
//     "trx_ptipe": "2",
//     "trx_date_created": "2021-11-04 14:07:05",
//     "trx_nominal": "1500000",
//     "trx_ket": "testing 1.5 jt",
//     "trx_asal_outlet_id": "1",
//     "trx_outlet_id": "1"
// },

// To parse this JSON data, do
//
//     final stokGet = stokGetFromJson(jsonString);

import 'dart:convert';

StokGet stokGetFromJson(String str) => StokGet.fromJson(json.decode(str));

String stokGetToJson(StokGet data) => json.encode(data.toJson());

class StokGet {
    StokGet({
        required this.trxPtipeNama,
        required this.trxCurtipeVar,
        required this.trxAsalOutletNama,
        required this.trxDarikeOutletId,
        required this.trxDarikeOutletNama,
        required this.stokId,
        required this.trxId,
        required this.trxTgl,
        required this.trxPtipe,
        required this.trxDateCreated,
        required this.trxNominal,
        required this.trxKet,
        required this.trxAsalOutletId,
        required this.trxOutletId,
    });

    String trxPtipeNama;
    String trxCurtipeVar;
    String trxAsalOutletNama;
    String trxDarikeOutletId;
    String trxDarikeOutletNama;
    String stokId;
    String trxId;
    String trxTgl;
    String trxPtipe;
    String trxDateCreated;
    String trxNominal;
    String trxKet;
    String trxAsalOutletId;
    String trxOutletId;

    factory StokGet.fromJson(Map<String, dynamic> json) => StokGet(
        trxPtipeNama: json["trx_ptipe_nama"],
        trxCurtipeVar: json["trx_curtipe_var"],
        trxAsalOutletNama: json["trx_asal_outlet_nama"],
        trxDarikeOutletId: json["trx_darike_outlet_id"],
        trxDarikeOutletNama: json["trx_darike_outlet_nama"],
        stokId: json["stok_id"],
        trxId: json["trx_id"],
        trxTgl: json["trx_tgl"],
        trxPtipe: json["trx_ptipe"],
        trxDateCreated: json["trx_date_created"],
        trxNominal: json["trx_nominal"],
        trxKet: json["trx_ket"],
        trxAsalOutletId: json["trx_asal_outlet_id"],
        trxOutletId: json["trx_outlet_id"],
    );

    Map<String, dynamic> toJson() => {
        "trx_ptipe_nama": trxPtipeNama,
        "trx_curtipe_var": trxCurtipeVar,
        "trx_asal_outlet_nama": trxAsalOutletNama,
        "trx_darike_outlet_id": trxDarikeOutletId,
        "trx_darike_outlet_nama": trxDarikeOutletNama,
        "stok_id": stokId,
        "trx_id": trxId,
        "trx_tgl": trxTgl,
        "trx_ptipe": trxPtipe,
        "trx_date_created": trxDateCreated,
        "trx_nominal": trxNominal,
        "trx_ket": trxKet,
        "trx_asal_outlet_id": trxAsalOutletId,
        "trx_outlet_id": trxOutletId,
    };

  static List<StokGet> fromJsonList(List list) {
    if (list.isEmpty) return List<StokGet>.empty();
    return list.map((item) => StokGet.fromJson(item)).toList();
  }

}
