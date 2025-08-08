import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get pdfapiKey => dotenv.env['PDF_API_KEY'] ?? '';
  static String get username => dotenv.env['USERNAME'] ?? '';
  static String get password => dotenv.env['PASSWORD'] ?? '';
  static String get appName => dotenv.env['APP_NAME'] ?? 'Sumul Transport';
}
