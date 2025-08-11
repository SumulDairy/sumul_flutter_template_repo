// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:sumul_hr/presentation/common_screen/auth/view/change_password.dart';
import 'package:sumul_hr/presentation/common_screen/auth/view/otpscreen.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/aboutus/view/aboutus_view.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/newsalert/view/notification_view.dart';
import 'package:sumul_hr/routes/app_bindings.dart';
import 'package:sumul_hr/presentation/common_screen/auth/view/login_view.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/view/dashboard_view.dart';
import 'package:sumul_hr/presentation/common_screen/splash/view/splash_view.dart';

class Routes {
  Routes._();

  static const SPLASH_SCREEN = '/splash_screen';
  static const HOME_SCREEN = '/home_screen';
  static const AUTH_SCREEN = '/auth_screen';
  static const OTP_SCREEN = '/otp_screen';
  static const CHANGEPASSWORD_SCREEN = '/change_password_screen';
  static const CATEGORY_SCREEN = '/category_screen';
  static const AGENT_SELECTION_SCREEN = '/agent_selectio_screen';
  static const DASHBOARD_SCREEN = '/dashboard_screen';

  // Menu -- Order
  static const PLACE_ORDER_SCREEN = '/place_order_screen_screen';
  static const AGENT_PRODUCTCATEGORY_SCREEN = '/agent_product_category_screen';
  static const COPY_ORDER_SCREEN = '/copy_order_screen';
  static const EXTRA_ORDER_SCREEN = '/extra_order_screen';
  static const GATEPASS_ORDER_SCREEN = '/gatepass_order_screen';
  static const BAKERY_ORDER_SCREEN = '/bakery_order_screen';

  //Dairy Product
  // --Order
  static const DP_PLACE_ORDER_SCREEN = '/dp_place_order_screen_screen';
  static const DP_COPY_ORDER_SCREEN = '/dp_copy_order_screen';
  static const DP_CONFIRM_ORDER_SCREEN = '/dp_confirm_order_screen';
  //Order - History
  static const DP_VIEW_PREVIOUS_PLACE_ORDER_SCREEN =
      '/dp_view_place_order_screen';

  //Bakery
  // --Order
  static const BK_PLACE_ORDER_SCREEN = '/bk_place_order_screen_screen';
  static const BK_COPY_ORDER_SCREEN = '/bk_copy_order_screen';
  static const BK_DATEWISE_BALANCE_SCREEN = '/bk_datewisebalance_screen';

  //Order - History
  static const BK_VIEW_PREVIOUS_PLACE_ORDER_SCREEN =
      '/bk_view_place_order_screen';
  //Cash Managent
  static const CASH_ENTRY_SCREEN = '/cash_entry_screen';
  static const CASH_ENTRY_VIEW_SCREEN = '/cash_entry_view_screen';

  //Daily Slip
  static const DAILY_SLIP_SCREEN = '/daily_slip_screen';
  static const STATEMENT_SCREEN = '/statement_screen';
  static const DATEWISE_BALANCE_SCREEN = '/datewisebalance_screen';

  //View Order
  static const VIEW_PREVIOUS_PLACE_ORDER_SCREEN = '/view_place_order_screen';
  static const VIEW_PREVIOUS_GATEPASS_ORDER_SCREEN =
      '/view_gatepass_order_screen';
  static const VIEW_PREVIOUS_EXTRA_ORDER_SCREEN = '/view_extra_order_screen';

  //Drawer

  static const ABOUTUS_SCREEN = '/aboutus_screen';
  static const NOTIFICATION_SCREEN = '/notification_screen';

  //Distributor
  static const DIST_CATEGORY_SCREEN = '/dist_category_screen';

  static const DIST_PLACE_ORDER_SCREEN = '/dist_place_order_screen_screen';
  static const DIST_GATEPASS_ORDER_SCREEN = '/dist_gatepass_order_screen';
  static const DIST_VIEW_PREVIOUS_PLACE_ORDER_SCREEN =
      '/dist_view_place_order_screen';
  static const DIST_VIEW_PREVIOUS_GATEPASS_ORDER_SCREEN =
      '/dist_view_gatepass_order_screen';
  static const DIST_VIEW_PREVIOUS_EXTRA_ORDER_SCREEN =
      '/dist_view_extra_order_screen';

  static const DIST_CRATE_BALANCE_SCREEN = '/dist_crate_balance_screen';

  static final routes = [
    GetPage(
      name: SPLASH_SCREEN,
      page: () => const SplashView(),
      transition: Transition.native,
    ),
    GetPage(
      name: AUTH_SCREEN,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: OTP_SCREEN,
      page: () => Otpscreen(),
      binding: OtpBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: DASHBOARD_SCREEN,
      page: () => DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.fadeIn,
    ),

    // Order Management

    // Drawer Menus
    GetPage(
      name: ABOUTUS_SCREEN,
      page: () => AboutusView(),
      binding: AboutusBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: CHANGEPASSWORD_SCREEN,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: NOTIFICATION_SCREEN,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      transition: Transition.fadeIn,
    ),

    //Dp
  ];
}
