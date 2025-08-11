import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/auth_model.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/otp_model.dart';
import 'package:sumul_hr/presentation/common_screen/auth/repository/otp_repository.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/routes/app_routes.dart';
import 'package:sumul_hr/widgets/show_comman_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpController extends GetxController {
  // //For Otp
  RxString otpCode = ''.obs;
  RxBool isObscure = true.obs;
  final otpformKey = GlobalKey<FormState>();
  SendOtpResponseData sendResponseData = SendOtpResponseData();
  var isConnected = RxBool(true);
  var isLoading = RxBool(false);

  @override
  void onInit() {
    if (Get.arguments != null) {
      sendResponseData = Get.arguments;
    }

    super.onInit();
  }

  void verifyOtpClick() async {
    if (otpCode.value.length == 4 &&
        (!(AllFunction.isStringNullOrEmptyOrBlank(
          sendResponseData.otp.toString(),
        )))) {
      try {
        if (otpCode.value == sendResponseData.otp.toString()) {
          isLoading.value = false;
          AppServices.settings.empNo = sendResponseData.custcd ?? "";
          AppServices.settings.name = sendResponseData.custname ?? "";
          AppServices.settings.mobileNo = sendResponseData.mobileno ?? "";

          if (AppServices.settings.isUserLoggedIn) {
            logOutAll();
          } else {
            deviceCheck();
          }
        } else {
          isLoading.value = false;
          await Get.dialog(
            ShowAleartComman(
              title: StringConstants.warning,
              content: StringConstants.loginScreenValidOtp,
            ),
          );
        }

        // Get.snackbar(StringConstants.success, message)
      } catch (e) {
        isLoading.value = false;

        await Get.dialog(
          ShowAleartComman(
            title: StringConstants.error,
            content: StringConstants.loginScreenValidOtp,
          ),
        );
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      await Get.dialog(
        ShowAleartComman(
          title: StringConstants.warning,
          content: StringConstants.loginScreenValidOtp,
        ),
      );
    }
  }

  void back() {
    Get.back();
  }

  void deviceCheck() async {
    try {
      isLoading.value = true;

      DeviceCheckInputModel input = DeviceCheckInputModel();
      input.deviceid = AppServices.settings.deviceInfo;
      input.mobileno = int.tryParse(AppServices.settings.mobileNo);
      var dveviceModel =
          await OtpRepository().deviceCheck(input: input) ??
          DeviceCheckResponsetModel();

      if ((dveviceModel.status ?? false)) {
        if (dveviceModel.data != null) {
          isLoading.value = false;
          AppServices.settings.userId = dveviceModel.data?.id ?? "";
          Get.focusScope?.unfocus();
          AppServices.settings.isUserLoggedIn = true;

          AppServices.settings.isDistributor
              ? Get.toNamed(Routes.DIST_CATEGORY_SCREEN)
              : Get.toNamed(Routes.CATEGORY_SCREEN);
        } else {
          AppServices.settings.isUserLoggedIn = false;
          await Get.dialog(
            ShowAleartComman(
              title: StringConstants.alert.capitalized,
              content:
                  dveviceModel.message ??
                  "${StringConstants.noRecordFound} for ${input.mobileno}",
            ),
          );
        }
      } else {
        isLoading.value = false;
        await Get.dialog(
          ShowAleartComman(
            title: "Error",
            content:
                dveviceModel.message ?? "No Record found for ${input.mobileno}",
          ),
        );
      }
    } catch (e) {
      isLoading.value = false;
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
    }
  }

  void logOutAll({bool? isAsk = true}) async {
    try {
      isLoading.value = true;
      await Get.dialog(
        ShowAleartComman(
          title: StringConstants.alert.capitalized,
          content: "${StringConstants.logOutText} ?",
          isLogout: true,
        ),
      ).then((value) async {
        if (value != null) {
          if (value == StringConstants.yes) {
            Get.back();
            await logOut();
          } else {
            // stopNotificationPolling();
            AppServices.settings.unreadCount = 0;
            Get.back();
          }
        }
      });
    } catch (e) {
      isLoading.value = false;
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
    }
  }

  Future<void> logOut() async {
    var result = await OtpRepository().logoutAll();
    if ((result?.status ?? false)) {
      AppServices.settings.userId = "";
      AllFunction.logout();
    }
  }
}
