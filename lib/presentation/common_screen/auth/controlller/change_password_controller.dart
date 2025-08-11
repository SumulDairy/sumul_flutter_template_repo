import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/change_password_model.dart';
import 'package:sumul_hr/presentation/common_screen/auth/repository/auth_repository.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/widgets/show_comman_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangePasswordController extends GetxController {
  //For Form Fields
  final changePasswordformKey = GlobalKey<FormState>();
  final passwordController = TextEditingController().obs;
  final newpasswordController = TextEditingController().obs;
  final cnfpasswordController = TextEditingController().obs;
  Rx<ChangePasswordInputModel> inpumodel = ChangePasswordInputModel().obs;

  // //For Otp
  final isObscureOld = true.obs;
  final isObscureNew = true.obs;
  final isObscureCnf = true.obs;

  var isConnected = RxBool(true);
  var isLoading = RxBool(false);

  Future<void> changePassword() async {
    if (changePasswordformKey.currentState!.validate()) {
      try {
        var connected = await AllFunction.checkConnectivity();
        if (connected) {
          isLoading.value = true;

          inpumodel.value.custcd = AppServices.settings.selectedAgent;
          inpumodel.value.newPass = newpasswordController.value.text;
          inpumodel.value.oldPass = passwordController.value.text;
          var response = await AuthRepository().changePasswordServiceCall(
            input: inpumodel.value,
          );

          if ((response?.status ?? false)) {
            if (AllFunction.isStringNullOrEmptyOrBlank(response?.data ?? "")) {
              isLoading.value = false;
              await Get.dialog(
                ShowAleartComman(
                  title: StringConstants.success.capitalized,
                  content: response?.message ?? "",
                ),
              );
              Get.focusScope?.unfocus();
            } else {
              await Get.dialog(
                ShowAleartComman(
                  title: StringConstants.alert.capitalized,
                  content: response?.message ?? "",
                ),
              );
            }
          } else {
            isLoading.value = false;
            await Get.dialog(
              ShowAleartComman(
                title: "Error",
                content: response?.message ?? "",
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

  void toggleObscure(RxBool field) => field.toggle();

  @override
  void onClose() {
    passwordController.value.clear();
    newpasswordController.value.clear();
    cnfpasswordController.value.clear();
    super.onClose();
  }
}
