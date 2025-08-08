import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sumul_transport/di/di_helper_services.dart';
import 'package:sumul_transport/presentation/create_balance/model/crate_balance_model.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

class CrateBalancePdfView extends StatelessWidget {
  final Rx<CrateBalanceDetailResponseModel>? model;
  // final Rx<CrateTransportResponseData> transporter;

  const CrateBalancePdfView({
    super.key,
    required this.model,
    // required this.transporter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => _generatePdf(
          format,
          model?.value ?? CrateBalanceDetailResponseModel(),
        ),
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        allowPrinting: false,
        padding: EdgeInsets.all(0),

        allowSharing: false,
        scrollViewDecoration: BoxDecoration(color: Colors.grey.shade100),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    CrateBalanceDetailResponseModel model,
  ) async {
    final pdf = pw.Document();
    List<List<String>>? tableData;

    tableData =
        model.data?.map((e) {
          return [
            e.date ?? '',
            e.morEve ?? '',
            e.despCrates?.toString() ?? '',
            e.retCrates?.toString() ?? '',
            e.cratesBal?.toString() ?? '',
          ];
        }).toList() ??
        [];

    // Add the Total row (NOT to model.data, but to tableData)
    tableData.add([
      '',
      'Total',
      model.despCratestot?.toStringAsFixed(2) ?? '0.00',
      model.retCratestot?.toStringAsFixed(2) ?? '0.00',
      model.retCratestot?.toStringAsFixed(2) ?? '0.00',
    ]);

    // Convert your model data to List<List<String>> for the table

    // Totals
    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        margin: pw.EdgeInsets.symmetric(
          horizontal: Sizer.s16,
          vertical: Sizer.s10,
        ),
        build: (context) => [
          pw.Header(
            level: 1,
            child: pw.Text(
              'Crate Balance Report',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),

          pw.Text(
            'TransPort: ${model.transportername} ${model.transportercd}',
            style: pw.TextStyle(
              fontSize: Sizer.font(Sizer.s20),
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Text(
            'Vehicle: ${model.transportData?.vehicle}',
            style: pw.TextStyle(
              fontSize: Sizer.font(Sizer.s20),
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Text(
            'Select Month : ${model.transportData?.selectedMonth}',
            style: pw.TextStyle(
              fontSize: Sizer.font(Sizer.s20),
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: Sizer.s20),
          if (model.data?.isNotEmpty ?? false)
            pw.TableHelper.fromTextArray(
              border: pw.TableBorder.all(width: 0.5),

              headers: [
                'Date',
                'Mor/Eve',
                'Desp. Crates',
                'Ret. Crates',
                'Bal',
              ],
              data: tableData ?? [],
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
                fontSize: Sizer.font(Sizer.s16),
              ),
              cellStyle: pw.TextStyle(fontSize: Sizer.font(Sizer.s20)),
              headerDecoration: pw.BoxDecoration(
                color: PdfColors.lightBlue,
                border: pw.TableBorder.all(
                  width: 0.5,
                  color: PdfColors.grey200,
                ),
              ),
              cellPadding: pw.EdgeInsets.symmetric(
                vertical: Sizer.s10,
                horizontal: Sizer.s10,
              ),
            ),
        ],
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }
}
