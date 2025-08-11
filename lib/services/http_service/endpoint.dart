import 'package:sumul_hr/appconfig/appconfig.dart';

class ServiceEndPoint {
  // NOTE - Base URL
  static String get baseUrl => AppConfig.baseUrl;
  // static get baseUrl => 'http://info.sumul.coop:8089///morder/';

  //Common Logout / Device Check
  static get deviceCheck => "DeviceCheck";
  static get deviceLogout => "DeviceLogout?mobileno=";

  // LINK - Milk Services
  static get sendOtp => "GetCustOtp?mobile=";
  static get getCustomer => "GetCustomer?id=";
  static get getProduct => "GetProduct?custcd=";

  static get getOrderTime => "GetOrderTime";
  static get changePassword => "ChngMPass";

  //Add Order
  static get saveOrder => "SaveOrder";
  static get getCopyOrder => "getCopyOrder?custcd=";

  //View Order
  static get getOrder => "GetOrder?custcd=";
  static get getGpOrder => "GetGpOrder?custcd=";

  //Cash Managment

  static get getCash => "GetCash?custcd=";
  static get saveCash => "SaveCash";
  static get getCashSlip => "GetCashSlip?custcd=";

  //Reporst
  static get getDailySlip => "DailySlip?custcd=";
  static get dateWiseBal => "DateWiseBal?custcd=";
  static get getcustSlip => "CustSlip";

  //NewsAlert
  static get getNewsAlert => "NewsAlert?custcd=";
  static get updateNotificationStatus => "MsgStatus";

  //About us
  static get getAboutUs => "contactus";

  //Notify
  static get getOrderStatus => "OrderStatus?custcd=";

  //DP  //Bakery Service
  static get getSubProduct => "GetProduct_db?id=";
  static get getCopyProductdb => "GetCopyOrder_db?custcd=";
  static get getDpViewOrderdb => "GetOrder_db?custcd=";
  static get getdDpConfirmOrder => "ConfirmOrder?custcd=";
  static get saveDpOrder => "SaveDpOrder";
  static get saveCopyOrderdp => "SaveCopyOrder_dp";
  static get saveConfirmOrder => "SaveConfirmOrder";
  static get saveBkOrder => "SaveBkOrder";
  static get saveCopyOrderbk => "SaveCopyOrder_bk";
  static get dateWiseBalbk => "DateWiseBal_bk?custcd=";

  //Distributore

  static get distGetCustomer => "DistGetCustomer?id=";
  static get distGetProduct => "/DistGetProduct?custcd=";

  static get distSaveOrder => "DistSaveOrder";
  static get distGetOrder => "DistGetOrder?id=";
  static get getTransport => "GetDistCrate?mdi=";
  static get getCrateBalance => "GetCrateBalance?mdi=";

  //  NOTE - Common
  static get commonErrorMessage => "Something went wrong";
}
