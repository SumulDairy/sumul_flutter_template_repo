// // exit_app_with_pop_scope_view.dart
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:sumul_transport/resources/app_color.dart';

// class ExitAppWithPopScopeHelper {
//   static Future<bool> onWillPop() async {
//     // Close dialog if open
//     if (Get.isDialogOpen ?? false) {
//       Get.back();
//       return false;
//     }

//     // Show confirmation dialog
//     bool? shouldExit = await Get.defaultDialog<bool>(
//       title: 'Exit App',
//       middleText: 'Are you sure you want to exit?',
//       textConfirm: 'Yes',
//       textCancel: 'No',
//       confirmTextColor: AppColor.primaryColor,
//       onConfirm: () => Get.back(result: true),
//       onCancel: () => Get.back(result: false),
//     );

//     if (shouldExit == true) {
//       SystemNavigator.pop(); // Exit app
//     }

//     return false; // prevent automatic pop, since we manually handled it
//   }
// }

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/widgets/show_comman_alert.dart'; // Import your dialog

class ExitAppWithPopScopeHelper {
  static Future<bool> onWillPop() async {
    // Close dialog if already open
    if (Get.isDialogOpen ?? false) {
      Get.back();
      return false;
    }

    // Show custom confirmation alert
    final result = await Get.dialog<String>(
      ShowAleartComman(
        title: StringConstants.exitAppTitle,
        content: StringConstants.exitAppMessage,
        isLogout: true, // shows Yes/No button layoutπ
      ),
    );

    if (result == StringConstants.yes) {
      SystemNavigator.pop(); // Exit app
    }

    return false; // prevent automatic pop
  }
}
