// {
//     "trx_id": "1",
//     "trx_date_created": "2021-11-08 14:41:22",
//     "trx_tgl": "2021-11-08",
//     "trx_ptipe": "1",
//     "trx_nominal": "10000000",
//     "trx_cur_tipe": "1",
//     "trx_ket": "dapet dari boss",
//     "trx_photo": null,
//     "trx_asal_outlet_id": "1",
//     "trx_darike_outlet_id": "0",
//     "trx_bayar_via": "1",
//     "trx_user_id": "1",
//     "trx_outlet_id": "1",
//     "trx_status": "1",
//     "trx_is_stok": "0",
//     "trx_date_modif": "2021-11-08 14:41:36",
//     "trx_deleted": "0",
//     "trx_deleted_by": "0",
//     "trx_deleted_ket": null,
//     "ptipe_nama": "Masuk",
//     "paytipe_nama": "TUNAI"
// }

// To parse this JSON data, do
//
//     final trxGetHistory = trxGetHistoryFromJson(jsonString);

import 'dart:convert';

TrxGetHistory trxGetHistoryFromJson(String str) =>
    TrxGetHistory.fromJson(json.decode(str));

String trxGetHistoryToJson(TrxGetHistory data) => json.encode(data.toJson());

class TrxGetHistory {
  TrxGetHistory({
    required this.trxId,
    required this.trxDateCreated,
    required this.trxTgl,
    required this.trxPtipe,
    required this.trxNominal,
    required this.trxCurTipe,
    required this.trxKet,
    required this.trxPhoto,
    required this.trxAsalOutletId,
    required this.trxDarikeOutletId,
    required this.trxBayarVia,
    required this.trxUserId,
    required this.trxOutletId,
    required this.trxStatus,
    required this.trxIsStok,
    required this.trxDateModif,
    required this.trxDeleted,
    required this.trxDeletedBy,
    required this.trxDeletedKet,
    required this.ptipeNama,
    required this.paytipeNama,
  });

  String trxId;
  String trxDateCreated;
  String trxTgl;
  String trxPtipe;
  String trxNominal;
  String trxCurTipe;
  String trxKet;
  String trxPhoto;
  String trxAsalOutletId;
  String trxDarikeOutletId;
  String trxBayarVia;
  String trxUserId;
  String trxOutletId;
  String trxStatus;
  String trxIsStok;
  String trxDateModif;
  String trxDeleted;
  String trxDeletedBy;
  String trxDeletedKet;
  String ptipeNama;
  String paytipeNama;

  factory TrxGetHistory.fromJson(Map<String, dynamic> json) => TrxGetHistory(
        trxId: json["trx_id"],
        trxDateCreated: json["trx_date_created"],
        trxTgl: json["trx_tgl"],
        trxPtipe: json["trx_ptipe"],
        trxNominal: json["trx_nominal"],
        trxCurTipe: json["trx_cur_tipe"],
        trxKet: json["trx_ket"],
        trxPhoto: json["trx_photo"] ?? '',
        trxAsalOutletId: json["trx_asal_outlet_id"],
        trxDarikeOutletId: json["trx_darike_outlet_id"],
        trxBayarVia: json["trx_bayar_via"],
        trxUserId: json["trx_user_id"],
        trxOutletId: json["trx_outlet_id"],
        trxStatus: json["trx_status"],
        trxIsStok: json["trx_is_stok"],
        trxDateModif: json["trx_date_modif"],
        trxDeleted: json["trx_deleted"],
        trxDeletedBy: json["trx_deleted_by"],
        trxDeletedKet: json["trx_deleted_ket"] ?? '',
        ptipeNama: json["ptipe_nama"],
        paytipeNama: json["paytipe_nama"],
      );

  Map<String, dynamic> toJson() => {
        "trx_id": trxId,
        "trx_date_created": trxDateCreated,
        "trx_tgl": trxTgl,
        "trx_ptipe": trxPtipe,
        "trx_nominal": trxNominal,
        "trx_cur_tipe": trxCurTipe,
        "trx_ket": trxKet,
        "trx_photo": trxPhoto,
        "trx_asal_outlet_id": trxAsalOutletId,
        "trx_darike_outlet_id": trxDarikeOutletId,
        "trx_bayar_via": trxBayarVia,
        "trx_user_id": trxUserId,
        "trx_outlet_id": trxOutletId,
        "trx_status": trxStatus,
        "trx_is_stok": trxIsStok,
        "trx_date_modif": trxDateModif,
        "trx_deleted": trxDeleted,
        "trx_deleted_by": trxDeletedBy,
        "trx_deleted_ket": trxDeletedKet,
        "ptipe_nama": ptipeNama,
        "paytipe_nama": paytipeNama,
      };

  static List<TrxGetHistory> fromJsonList(List list) {
    if (list.isEmpty) return List<TrxGetHistory>.empty();
    return list.map((item) => TrxGetHistory.fromJson(item)).toList();
  }
}
