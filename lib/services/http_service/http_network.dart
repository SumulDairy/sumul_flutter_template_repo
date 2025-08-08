// global/services/api_service.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sumul_transport/appconfig/appconfig.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/services/http_service/endpoint.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/widgets/show_comman_alert.dart';
//

class ApiService {
  static Future<Map<String, String>> getHeaders({
    bool isMultipart = false,
  }) async {
    // final token = AppServices.settings.accessToken;

    final headers = {
      if (!isMultipart) 'Content-Type': 'application/json',
      'Accept': 'application/json',
      // if (token.isNotEmpty) 'x-access-token': token,
    };

    // final credentials = base64Encode(utf8.encode('abc:testuhduydi'));
    headers['Authorization'] = createBasicAuthHeader(
      username: AppConfig.username,
      password: AppConfig.password,
    );

    return headers;
  }

  static String createBasicAuthHeader({String? username, String? password}) {
    final credentials = base64Encode(utf8.encode('$username:$password'));
    return 'Basic $credentials';
  }

  /// 🔄 Multipart Request
  static Future<T?> multipartRequest<T>({
    required String path,
    required Map<String, String> fields,
    String? fileContent, // base64 string or plain text
    String? fileFieldName,
    String? fileName, // Optional filename
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse('${ServiceEndPoint.baseUrl}$path');
      final request = http.MultipartRequest("POST", uri);

      request.headers.addAll(await getHeaders(isMultipart: true));

      // Add fields
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add file from string if provided
      if (fileContent != null && fileFieldName != null) {
        final multipartFile = http.MultipartFile.fromString(
          fileFieldName,
          fileContent,
          // filename: fileName ?? 'upload.jpg',
          // contentType: MediaType('image', 'jpeg'), // Adjust if needed
        );
        request.files.add(multipartFile);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      AllFunction.safeLog('🔄 Multipart Status: ${response.statusCode}');
      AllFunction.safeLog('🔄 Multipart Body: ${response.body}');

      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      } else {
        Get.snackbar("Error", "Something went wrong: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      AllFunction.safeLog('❌ Multipart Exception: $e');
      Get.snackbar("Error", "Multipart failed: $e");
      return null;
    }
  }

  static Future<T?> request<T>({
    required String path,
    required HttpMethod method,
    dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    bool isFormData = false,
    bool showDebug = true,
  }) async {
    try {
      final headers = await getHeaders();
      var url = ('${ServiceEndPoint.baseUrl}$path').trim();
      final uri = Uri.parse(url);

      http.Response response;

      if (showDebug) {
        AllFunction.safeLog('🔹Request: $method $uri');
        AllFunction.safeLog('🔹Headers: $headers');
        AllFunction.safeLog('🔹Data: $data');
      }

      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: headers);
          break;
        case HttpMethod.post:
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        case HttpMethod.put:
          response = await http.put(
            uri,
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        case HttpMethod.patch:
          response = await http.patch(
            uri,
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        case HttpMethod.delete:
          response = await http.delete(uri, headers: headers);
          break;
      }

      if (showDebug) {
        AllFunction.safeLog('🔹Status Code: ${response.statusCode}');
        AllFunction.safeLog('🔹Response Body: ${response.body}');
      }

      // if (response.statusCode == 200) {
      //   final json = jsonDecode(response.body);
      //   return fromJson(json);
      // } else {
      //   //    await Get.dialog(
      //   //   ShowAleartComman(
      //   //     title: StringConstants.error,
      //   //     content: StringConstants.loginScreenValidOtp,
      //   //   ),
      //   // );
      //   //   Get.snackbar("Error", "Something went wrong: ${response.statusCode}");
      //   return null;
      // }
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return fromJson(json);
      } else {
        String fallbackMessage = "Something went wrong: ${response.statusCode}";

        switch (response.statusCode) {
          case 400:
            fallbackMessage = "Bad request. Please try again.";
            break;
          case 401:
            fallbackMessage = "Unauthorized. Please login again.";
            break;
          case 403:
            fallbackMessage = "Access denied. You do not have permission.";
            break;
          case 404:
            fallbackMessage = "Not found. The resource doesn't exist.";
            break;
          case 422:
            fallbackMessage = "Unprocessable request. Check your inputs.";
            break;
          case 500:
            fallbackMessage = "Server error. Please try again later.";
            break;
          case 503:
            fallbackMessage =
                "Service unavailable. Please try after some time.";
            break;
          default:
            fallbackMessage =
                "Unexpected error occurred: ${response.statusCode}";
        }
        // Show error to user
        await Get.dialog(
          ShowAleartComman(
            title: StringConstants.error,
            content: fallbackMessage,
          ),
        );

        return null;
      }
    } catch (e) {
      AllFunction.safeLog("ERROR=======>${e.toString()}}");
      return null;
    }
  }
}

// final response = await ApiService.multipartRequest<BaseResponseModel>(
//   path: ServiceConfiguration.addVisit,
//   fields: {
//     'VISITNO': visitInput.visitno ?? "",
//     'EMPNO': visitInput.empno ?? "",
//     // ... other fields
//   },
//   fileContent: selectedFile, // base64 or raw string
//   fileFieldName: visitInput.visitno.isNullOrBlank ? 'OPENKM_IMAGE' : 'CLOSEKM_IMAGE',
//   fileName: 'image.jpg',
//   fromJson: (json) => BaseResponseModel.fromJson(json),
// );
