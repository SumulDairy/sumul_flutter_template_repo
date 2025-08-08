import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sumul_transport/presentation/ledger/model/ledger_model.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

class LedgerPdfView extends StatelessWidget {
  final Rx<LedgerResponseModel> model;

  const LedgerPdfView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => _generateLedgerPdf(format, model),
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        allowPrinting: false,
        padding: EdgeInsets.all(0),
        allowSharing: false,
        scrollViewDecoration: BoxDecoration(color: Colors.white),
      ),
    );
  }

  Future<Uint8List> _generateLedgerPdf(
    PdfPageFormat format,
    Rx<LedgerResponseModel> model,
  ) async {
    final pdf = pw.Document();

    // Headers
    final headers = [
      'Cust Code',
      'Date',
      'Product',
      'Unit',
      'Ltr',
      'Debit Amt',
      'Reason',
    ];

    // // Data rows
    // final dataRows = model.value.data?.map((e) {
    //   return [
    //     e.custcd,
    //     e.dt,
    //     e.product,
    //     e.unit.toString(),
    //     e.ltrs?.toStringAsFixed(2),
    //     e.debitamt?.toStringAsFixed(2),
    //     e.reason,
    //   ];
    // }).toList();

    // Convert your model data to List<List<String>> for the table
    final dataRows = model.value.data?.map((e) {
      return [
        e.custcd,
        e.dt,
        e.product,
        e.unit.toString(),
        e.ltrs?.toStringAsFixed(2),
        e.debitamt?.toStringAsFixed(2),
        e.reason,
      ];
    }).toList();

    // Add the Total row (NOT to model.data, but to tableData)
    dataRows?.add([
      '',
      '',
      'Total',
      model.value.unittot?.toStringAsFixed(2) ?? '0.00',
      model.value.ltrstot?.toStringAsFixed(2) ?? '0.00',
      model.value.amttot?.toStringAsFixed(2) ?? '0.00',
      '',
    ]);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        build: (context) {
          return [
            _buildProductHeaderEntry(model.value),
            pw.SizedBox(height: 20),
            pw.Text(
              'Return Penalty',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: Sizer.font(Sizer.s24),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
              border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey),
              headers: headers,
              data: dataRows ?? [],
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
                fontSize: Sizer.s14,
              ),
              headerDecoration: pw.BoxDecoration(
                color: PdfColors.lightBlue,
                border: pw.TableBorder.all(
                  width: 0.5,
                  color: PdfColors.green200,
                ),
              ),
              cellStyle: const pw.TextStyle(fontSize: Sizer.s12),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.center,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
                5: pw.Alignment.centerRight,
                6: pw.Alignment.centerLeft,
              },
              columnWidths: {
                0: pw.FlexColumnWidth(1), // Wider column
                1: pw.FlexColumnWidth(1), // Normal width
                2: pw.FlexColumnWidth(2.5),
                3: pw.FlexColumnWidth(0.75),
                4: pw.FlexColumnWidth(1),
                5: pw.FlexColumnWidth(1.5),
                6: pw.FlexColumnWidth(1),
              },
              rowDecoration: pw.BoxDecoration(), // default even row
              oddRowDecoration: const pw.BoxDecoration(
                color: PdfColors.grey200,
              ),
            ),
          ];
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  pw.Widget _buildProductHeaderEntry(LedgerResponseModel h) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),

        pw.Text(
          'Select Month : ${model.value.month}-${model.value.year}',
          style: pw.TextStyle(
            fontSize: Sizer.font(Sizer.s16),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),

        pw.Text(
          'Transporter: ${h.transportername}-${h.transportercd}',
          style: pw.TextStyle(
            fontSize: Sizer.font(Sizer.s16),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Text(
          'Vehicle: ${h.transportData?.vehicle}',
          style: pw.TextStyle(
            fontSize: Sizer.font(Sizer.s16),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),

        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 0.5, color: PdfColors.lightBlue),
          headers: [
            'Unit',
            'ltrs',
            'Total AMT',
            'Total Debit AMT',
            'Total Net AMT',
          ],
          data: [
            [
              h.unittot ?? '',
              h.ltrstot?.toString() ?? '',
              h.amttot?.toString() ?? '',
              h.debittot?.toString() ?? '',
              h.totAmount?.toString() ?? '',
            ],
          ],
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
            fontSize: Sizer.font(Sizer.s18),
          ),
          headerDecoration: pw.BoxDecoration(
            color: PdfColors.lightBlue,
            border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey200),
          ),
          cellStyle: pw.TextStyle(fontSize: Sizer.font(Sizer.s16)),
          cellAlignment: pw.Alignment.center,
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(3),
            3: const pw.FlexColumnWidth(3),
            4: const pw.FlexColumnWidth(3),
          },
        ),
      ],
    );
  }
}
