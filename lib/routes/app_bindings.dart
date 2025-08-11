import 'package:get/get.dart';
import 'package:sumul_hr/presentation/common_screen/auth/controlller/auth_controlle.dart';
import 'package:sumul_hr/presentation/common_screen/auth/controlller/change_password_controller.dart';
import 'package:sumul_hr/presentation/common_screen/auth/controlller/otp_controller.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/controller/dashboard_controller.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/aboutus/controller/aboutus_controller.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/newsalert/controller/notification_controller.dart';
import 'package:sumul_hr/services/http_service/http_network.dart';

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

class AboutusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutusController>(() => AboutusController());
  }
}

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
