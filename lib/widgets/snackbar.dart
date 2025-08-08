import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/resources/app_color.dart';

class CommonSnackBar {
  static void error({String? title, String? message, Duration? duration}) {
    Get.snackbar(
      title ?? 'Error',
      message ?? '',
      margin: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColor.errorColor,
      colorText: AppColor.whiteColor,
      animationDuration: duration ?? const Duration(seconds: 1),
      duration: duration ?? const Duration(seconds: 1),
    );
  }

  static void success({String? title, String? message, Duration? duration}) {
    Get.snackbar(
      title ?? 'Success',
      message ?? '',
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.greenColor,
      colorText: AppColor.whiteColor,
      animationDuration: duration ?? const Duration(seconds: 1),
      duration: duration ?? const Duration(seconds: 1),
    );
  }
}
