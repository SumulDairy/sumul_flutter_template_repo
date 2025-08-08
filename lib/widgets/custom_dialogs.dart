// Common Dialogs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/resources/app_color.dart';

class CustomDialogs {
  void showCircularDialog(BuildContext context) {
    CircularDialog.showLoadingDialog(context);
  }

  void hideCircularDialog(BuildContext context) {
    Navigator.pop(context);
  }

  getDialog({
    String title = "Error",
    String desc = "Some Thing went wrong...",
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      content: Text(desc, textAlign: TextAlign.center),
      buttonColor: AppColor.hexGreyColor,
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}

class CircularDialog {
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(color: AppColor.hexGreyColor),
          ),
        );
      },
      barrierDismissible: false,
    );
  }
}
