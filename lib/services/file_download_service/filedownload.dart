import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/widgets/show_comman_alert.dart';

/// Utility to show an error dialog
void _showError(String message) {
  Get.dialog(ShowAleartComman(title: StringConstants.alert, content: message));
}

/// Convert a Base64-encoded PDF string and open it
Future<dynamic> convertBase64ToPDF(
  String base64String,
  String fileName, {
  bool? isOpen,
}) async {
  try {
    // Ensure filename has .pdf extension
    if (!fileName.toLowerCase().endsWith('.pdf')) {
      fileName += '.pdf';
    }

    // Decode the Base64 string
    Uint8List bytes = base64Decode(base64String);

    // Get device's documents directory
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);

    // Write the PDF file
    await file.writeAsBytes(bytes);

    // Open the PDF
    if ((isOpen ?? false)) {
      final result = await OpenFilex.open(file.path);
      if (result.type != ResultType.done) {
        _showError("Unable to open the file.");
      }
    }
    return file.path;
  } catch (e) {
    _showError("Error saving or opening PDF: $e");
  }
}

class FileDownloadService {
  /// Downloads a PDF file from a URL and opens it
  static Future<void> downloadAndOpenPdf({
    required String fileName,
    required String fileUrl,
  }) async {
    try {
      // Ensure filename has .pdf extension
      if (!fileName.toLowerCase().endsWith('.pdf')) {
        fileName += '.pdf';
      }

      // Get a safe directory to store file
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Download the file
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);

        // Open the file
        final openResult = await OpenFilex.open(filePath);
        if (openResult.type != ResultType.done) {
          _showError("Unable to open the file.");
        }
      } else {
        _showError("Download failed with status: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Download or open failed: $e");
    }
  }
}
