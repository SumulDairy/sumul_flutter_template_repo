import 'package:get/get.dart';
import 'package:sumul_transport/presentation/auth/view/login_view.dart';
import 'package:sumul_transport/presentation/auth/view/otpscreen.dart';
import 'package:sumul_transport/presentation/credit_debit/view/credir_debit_view.dart';
import 'package:sumul_transport/presentation/dashboard/view/dashboard_view.dart';
import 'package:sumul_transport/presentation/ledger/view/ledger_view.dart';
import 'package:sumul_transport/presentation/splash/view/splash_view.dart';
import 'package:sumul_transport/presentation/create_balance/view/crate_balance_view.dart';
import 'package:sumul_transport/routes/app_bindings.dart';

class Routes {
  Routes._();

  static const splashscreen = '/splash_screen';
  static const authscreen = '/auth_screen';
  static const otpscreen = '/otp_screen';
  static const dashboardscreen = '/dashboard_screen';
  static const cratebalancescreen = '/dist_crate_balance_screen';
  static const creditdebitscreen = '/credit_debit_screen';
  static const ledgerscreen = '/ledger_screen';

  static final routes = [
    GetPage(
      name: splashscreen,
      page: () => const SplashView(),
      transition: Transition.native,
    ),
    GetPage(
      name: authscreen,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: otpscreen,
      page: () => Otpscreen(),
      binding: OtpBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: dashboardscreen,
      page: () => DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: cratebalancescreen,
      page: () => CrateBalanceView(),
      binding: CrateBalanceBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: creditdebitscreen,
      page: () => CreaditDebitScreen(),
      binding: CreditDebitBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: ledgerscreen,
      page: () => LedgerScreen(),
      binding: LedgerBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
