import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:ugd6_b_9/view/temporary/preview_screenforPDF.dart';
import 'package:ugd6_b_9/entity/gerakanGym.dart';
import 'package:intl/intl.dart';

Future<pw.Document> generateDocument(
    List<Map<String, dynamic>> gerakanGym) async {
  final logo = (await rootBundle.load('assets/logo.png')).buffer.asUint8List();
  final image = pw.MemoryImage(logo);
 
  String id = const Uuid().v1();
  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  'Daftar Gerakan Gym',
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Image(
                  image,
                  width: 150,
                  height: 150,
                ),
              ),
              pw.Table(
                border:
                    pw.TableBorder.all(width: 2, style: pw.BorderStyle.solid),
                tableWidth: pw.TableWidth.max,
                children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'Nama Gerakan Gym',
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'Tingkat Kesulitan',
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'Deskripsi',
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  for (final gerakanGym in gerakanGym)
                    pw.TableRow(children: [
                      pw.Text(gerakanGym['namaGerakan']),
                      pw.Text(gerakanGym['tingkatKesulitan']),
                      pw.Text(gerakanGym['deskripsi']),
                    ]),
                ],
              ),
              pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: footerPdf(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString()),
              ),
              barcodeKotak(id),
            ],
          ),
        );
      }));
  return Future.value(doc);
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );

pw.Center footerPdf(String formattedDate) => pw.Center(
      child: pw.Text(
        'Created At $formattedDate',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
      ),
    );


pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 100, vertical: 100),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 150,
        height: 150,
      ),
    ),
  );
}