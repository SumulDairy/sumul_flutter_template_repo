import 'package:get/get.dart';
import 'package:sumul_transport/presentation/auth/controlller/auth_controlle.dart';
import 'package:sumul_transport/presentation/auth/controlller/otp_controller.dart';
import 'package:sumul_transport/presentation/credit_debit/controller/credit_debit_controller.dart';
import 'package:sumul_transport/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:sumul_transport/presentation/create_balance/controller/crate_balance_controller.dart';
import 'package:sumul_transport/presentation/ledger/controller/ledger_controller.dart';
import 'package:sumul_transport/services/http_service/http_network.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.put(ApiService(), permanent: true);
  }
}

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

class CrateBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrateBalanceController>(() => CrateBalanceController());
  }
}

class LedgerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LedgerScreenController>(() => LedgerScreenController());
  }
}

class CreditDebitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditDebitController>(() => CreditDebitController());
  }
}
