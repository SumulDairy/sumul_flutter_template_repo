import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sumul_transport/presentation/credit_debit/model/creditdebit_model.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

class CreditEntry {
  String? date;
  String? shift;
  String? amount;
  CreditEntry({this.date, this.amount, this.shift});
}

class DebitEntry {
  String? diesel;
  String? sCharge;
  String? damage;
  String? rentdeduction;
  DebitEntry({this.diesel, this.sCharge, this.damage, this.rentdeduction});
}

class CreditDebitPdf extends StatelessWidget {
  final Rx<CreditDebitResponseModel> model;
  const CreditDebitPdf({
    super.key,
    required this.model,
    // required this.ledgerList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,

      body: PdfPreview(
        pdfPreviewPageDecoration: BoxDecoration(color: AppColor.whiteColor),
        build: (format) => _generateLedgerPdf(format),
        canChangePageFormat: false,
        canChangeOrientation: false,
        dynamicLayout: true,
        allowPrinting: false,
        allowSharing: false,
        scrollViewDecoration: BoxDecoration(color: Colors.white),
      ),
    );
  }

  Future<Uint8List> _generateLedgerPdf(
    PdfPageFormat format,
    // List<ReturnPenaltyModel> ledgerList,
  ) async {
    final pdf = pw.Document();

    // Headers
    // final headers = [
    //   'Agent Code',
    //   'Date',
    //   'Product',
    //   'Unit',
    //   'Ltr',
    //   'Debit Amt',
    //   'Reason',
    // ];

    // Data rows
    // final dataRows = ledgerList.map((e) {
    //   return [
    //     e.agentCode,
    //     e.date,
    //     e.productDescription,
    //     e.unit.toString(),
    //     e.liters.toStringAsFixed(2),
    //     e.debitAmount.toStringAsFixed(2),
    //     e.reason,
    //   ];
    // }).toList();
    String getOnlyDay(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return '';
      return dateStr.split('-').first; // returns "23"
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        build: (context) {
          List<CreditEntry> creditList = (model.value.data ?? [])
              .map(
                (e) => CreditEntry(
                  date: getOnlyDay(e.date),
                  shift: e.time?.toString() ?? '0',
                  amount: e.rentDed?.toString() ?? '0',
                ),
              )
              .toList();

          List<String?> creditListHeader = ["Date", "Shift", "Amount"];
          List<String?> debitListHeader = [
            "Diesel",
            "S.Charge",
            "Damage",
            "Rent Deduction",
          ];
          List<DebitEntry> debitList = (model.value.data ?? [])
              .map(
                (e) => DebitEntry(
                  diesel: e.diesel?.toString() ?? '0',
                  sCharge: e.sCharge?.toString() ?? '0',
                  damage: e.damage?.toString() ?? '0',
                  rentdeduction: e.rentDed?.toString() ?? '0',
                ),
              )
              .toList();
          final dataRows = creditList.map((e) {
            return [e.date, e.shift, e.amount];
          }).toList();
          final dataRows1 = debitList.map((e) {
            return [e.diesel, e.sCharge, e.damage, e.rentdeduction];
          }).toList();

          // Totals
          final totalExtraRent = creditList.fold<double>(
            0.0,
            (sum, e) => sum + int.parse(e.amount ?? "0"),
          );
          final totalDiesel = debitList.fold<double>(
            0.0,
            (sum, e) => sum + int.parse(e.diesel ?? "0"),
          );
          final totalSCharge = debitList.fold<double>(
            0.0,
            (sum, e) => sum + int.parse(e.sCharge ?? "0"),
          );
          final totalDamage = debitList.fold<double>(
            0.0,
            (sum, e) => sum + int.parse(e.damage ?? "0"),
          );
          final totalRentDed = debitList.fold<double>(
            0.0,
            (sum, e) => sum + int.parse(e.rentdeduction ?? "0"),
          );

          final totalRow = ['', 'Total', totalExtraRent.toStringAsFixed(2)];
          final total1Row = [
            totalDiesel.toStringAsFixed(2),
            totalSCharge.toStringAsFixed(2),
            totalDamage.toStringAsFixed(2),
            totalRentDed.toStringAsFixed(2),
          ];

          // // Add total row at the end
          dataRows.add(totalRow);
          dataRows1.add(total1Row);
          return [
            _buildProductHeaderEntry(),

            pw.SizedBox(height: 20),
            pw.Text(
              'Datewise Credit / Debit Information',
              style: pw.TextStyle(
                fontSize: Sizer.s20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey),
              children: [
                // Header row
                pw.TableRow(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      color: PdfColors.lightBlue,
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        'Credit',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                          fontSize: Sizer.font(Sizer.s20),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: Sizer.s1),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      color: PdfColors.amber800,
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        'Debit',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                          fontSize: Sizer.font(Sizer.s20),
                        ),
                      ),
                    ),
                  ],
                ),

                // Row containing the actual tables inside Credit and Debit columns
                pw.TableRow(
                  children: [
                    /// CREDIT TABLE
                    pw.TableHelper.fromTextArray(
                      border: pw.TableBorder.all(
                        width: 0.5,
                        color: PdfColors.grey,
                      ),
                      headers: creditListHeader,
                      data: dataRows,
                      headerStyle: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                        fontSize: Sizer.font(Sizer.s16),
                      ),
                      headerDecoration: pw.BoxDecoration(
                        color: PdfColors.lightBlue,
                        border: pw.TableBorder.all(
                          width: 0.5,
                          color: PdfColors.green200,
                        ),
                      ),
                      cellStyle: pw.TextStyle(fontSize: Sizer.s16),
                      cellAlignments: {
                        0: pw.Alignment.center,
                        1: pw.Alignment.center,
                        2: pw.Alignment.center,
                      },
                      rowDecoration: pw.BoxDecoration(),
                      oddRowDecoration: const pw.BoxDecoration(
                        color: PdfColors.grey200,
                      ),
                    ),
                    pw.SizedBox(width: Sizer.s4),

                    /// DEBIT TABLE
                    pw.TableHelper.fromTextArray(
                      border: pw.TableBorder.all(
                        width: 0.5,
                        color: PdfColors.grey,
                      ),
                      headers: debitListHeader,
                      data: dataRows1,

                      headerStyle: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                        fontSize: Sizer.font(Sizer.s16),
                      ),
                      headerDecoration: pw.BoxDecoration(
                        color: PdfColors.amber800,
                        border: pw.TableBorder.all(
                          width: 0.5,
                          color: PdfColors.green200,
                        ),
                      ),
                      cellStyle: pw.TextStyle(fontSize: Sizer.s16),
                      cellAlignments: {
                        0: pw.Alignment.center,
                        1: pw.Alignment.center,
                        2: pw.Alignment.center,
                        3: pw.Alignment.center,
                      },
                      rowDecoration: pw.BoxDecoration(),
                      oddRowDecoration: const pw.BoxDecoration(
                        color: PdfColors.grey200,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  pw.Widget _buildProductHeaderEntry() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 12),
        pw.Text(
          'Select Month : ${model.value.month}-${model.value.year}',
          style: pw.TextStyle(
            fontSize: Sizer.font(Sizer.s16),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Text(
          'Transporter: ${model.value.transportername}-${model.value.transportercd}',
          style: pw.TextStyle(
            fontSize: Sizer.font(Sizer.s16),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 0.5, color: PdfColors.lightBlue),
          headers: ['Vehicle', 'Total Rent	', 'Advance'],
          data: [
            [
              model.value.vehicle,
              model.value.totrent?.toString() ?? '',
              model.value.advance?.toString() ?? '',
            ],
          ],
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
            fontSize: Sizer.font(Sizer.s20),
          ),
          headerDecoration: pw.BoxDecoration(
            color: PdfColors.lightBlue,
            border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey200),
          ),
          cellStyle: pw.TextStyle(fontSize: Sizer.s18),
          cellAlignment: pw.Alignment.center,
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
          },
        ),
      ],
    );
  }
}
