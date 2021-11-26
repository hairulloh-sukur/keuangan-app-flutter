// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan_app/controllers/trx_get_controller.dart';
import 'package:keuangan_app/models/trx_history_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfApi {
  // *Trx Get History

  static Future<File> generateReport(
      {required String outletName,
      required String tglMulai,
      required String tglAkhir}) async {
    final trxController = Get.find<TrxGetController>();

    List<TrxHistory> dataTable = trxController.listTrxHistory;

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: pw.EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          orientation: pw.PageOrientation.portrait,
        ),
        build: (pw.Context context) => <pw.Widget>[
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Tanggal Cetak: ' +
                  DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
              style: pw.TextStyle(fontSize: 8),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Periode: ' + tglMulai + ' s/d ' + tglAkhir,
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 15),
          pw.Header(
            child: pw.Text(
              outletName,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Table.fromTextArray(
            border: pw.TableBorder.all(),
            headerStyle:
                pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.amber100,
            ),
            data: <List<String>>[
              <String>[
                'Tanggal',
                'Keterangan',
                'Masuk IDR',
                'Keluar IDR',
                'Masuk USD',
                'Keluar USD',
                'Masuk EUR',
                'Keluar EUR',
                'Masuk SGD',
                'Keluar SGD'
              ],
              ...dataTable
                  .map((msg) => [
                        msg.trxTgl,
                        msg.trxKet,
                        msg.masukIdr,
                        msg.keluarIdr,
                        msg.masukUsd,
                        msg.keluarUsd,
                        msg.masukEur,
                        msg.keluarEur,
                        msg.masukSgd,
                        msg.keluarSgd
                      ])
                  .toList(),
              <String>[
                '',
                '',
                trxController.totalMasukIdr.value,
                trxController.totalKeluarIdr.value,
                trxController.totalMasukUsd.value,
                trxController.totalKeluarUsd.value,
                trxController.totalMasukEur.value,
                trxController.totalKeluarEur.value,
                trxController.totalMasukSgd.value,
                trxController.totalKeluarSgd.value,
              ],
            ],
            cellStyle: pw.TextStyle(fontSize: 6),
            cellAlignment: pw.Alignment.centerRight,
            cellAlignments: {1: pw.Alignment.centerLeft},
          ),
        ],
      ),
    );

    return saveDocument(
        name: outletName +
            '_' +
            DateFormat('yyyyMMddhhmmss').format(DateTime.now()) +
            '.pdf',
        pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
