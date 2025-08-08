import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/presentation/auth/models/auth_model.dart';
import 'package:sumul_transport/presentation/auth/repository/auth_repository.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/routes/app_routes.dart';
import 'package:sumul_transport/widgets/show_comman_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  //For Form Fields
  final authformKey = GlobalKey<FormState>();
  final usernameController = TextEditingController().obs;

  final passwordController = TextEditingController().obs;
  SendOtpResponseData sendResponseData = SendOtpResponseData();

  // //For Otp
  RxString otpCode = ''.obs;

  RxBool isObscure = true.obs;
  RxBool isFromAllDevice = false.obs;

  var isConnected = RxBool(true);
  var isLoading = RxBool(false);

  Future<void> sendOtpClick() async {
    if (authformKey.currentState!.validate()) {
      try {
        var connected = await AllFunction.checkConnectivity();
        if (connected) {
          isLoading.value = true;

          var sendResponse =
              await AuthRepository().sendOtpServiceCall(
                usernameController.value.text,
              ) ??
              SendOtpResponseModel();

          if ((sendResponse.status ?? false)) {
            if (sendResponse.data != null) {
              isLoading.value = false;
              sendResponseData = sendResponse.data ?? SendOtpResponseData();
              Get.focusScope?.unfocus();
              Get.toNamed(Routes.otpscreen, arguments: sendResponse.data);
            } else {
              await Get.dialog(
                ShowAleartComman(
                  title: StringConstants.alert.capitalized,
                  content:
                      sendResponse.message ??
                      "${StringConstants.noRecordFound} for ${usernameController.value.text}",
                ),
              );
            }
          } else {
            isLoading.value = false;
            await Get.dialog(
              ShowAleartComman(
                title: "Error",
                content:
                    sendResponse.message ??
                    "No Record found for ${usernameController.value.text}",
              ),
            );
          }
        } else {
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        AllFunction.safeLog("ERROR===>>>>${e.toString()}");
      }
    }
  }

  void back() {
    Get.back();
  }

  @override
  void onClose() {
    usernameController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}
