import 'package:sumul_transport/appconfig/appconfig.dart';

class ServiceEndPoint {
  // NOTE - Base URL
  static String get baseUrl => AppConfig.baseUrl;
  // static get baseUrl => 'http://info.sumul.coop:8089///morder/';

  //Common Logout / Device Check
  static get deviceCheck => "DeviceCheck";
  static get deviceLogout => "DeviceLogout?mobileno=";

  // LINK - Milk Services
  static get sendOtp => "GetTransOtp?mobile=";

  static get getTransport => "GetTransporter?mobile=";
  static get getTransCrDb => "GetTransCrDb?tcd=";
  static get getTransLdg => "GetTransLdg?tcd=";
  static get getCrateBalance => "GetDistCrateBalance?tcd=";

  //   https://api.sumul.coop/morder/GetTransporter?mobile=8780150993
  // https://api.sumul.coop/morder/GetTransCrDb?tcd=7826&month_year=JUL-2025
  // https://api.sumul.coop/morder/GetTransLdg?tcd=7826&month_year=AUG-2025

  //  NOTE - Common
  static get commonErrorMessage => "Something went wrong";
}
