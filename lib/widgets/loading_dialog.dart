import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';

void showLoadingDialog() {
  Get.dialog(
    Center(
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 86,
              width: 86,
              padding: const EdgeInsets.all(17),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 1.3,
                color: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
            Image.asset(ImageConstants.imgLogo, height: 38, width: 38),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideLoadingDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back(); // ✅ Only closes dialog, not full screen
  }
}
