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
import 'package:ugd6_b_9/entity/model/gerakanGym.dart';
import 'package:intl/intl.dart';

Future<pw.Document> generateInvoice() async {
  final logo = (await rootBundle.load('assets/logo.png')).buffer.asUint8List();
  final image = pw.MemoryImage(logo);

  final doc = pw.Document();

  doc.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return pw.Container(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(image, width: 150, height: 150),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Invoice',
                      style: pw.TextStyle(
                        fontSize: 30,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Date: ${DateTime.now().toString()}',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Bill To:',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Made Yosa Bagas Brawijaya',
              style: pw.TextStyle(fontSize: 14),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                width: 1,
                color: PdfColors.black,
              ),
              tableWidth: pw.TableWidth.max,
              children: [
                pw.TableRow(children: [
                  //bold text
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Id',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Name Subscription',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Expired Date',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Payment Method',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  PaddedText('1'),
                  PaddedText('Basic Package'),
                  PaddedText('1/1/2021'),
                  PaddedText('BCA'),
                ]),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  'Total: Rp. 200.000',
                  style: pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.Text(
                  'Tax: Rp. 7.500',
                  style: pw.TextStyle(fontSize: 14),
                ),
                //give line
                pw.Divider(
                  thickness: 1,
                  color: PdfColors.black,
                ),
                pw.Text(
                  'Total: Rp. 207.500',
                  style: pw.TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      );
    },
  ));

  return doc;
}

class PaddedText extends pw.StatelessWidget {
  final String text;

  PaddedText(this.text);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(8),
      child: pw.Text(text),
    );
  }
}
