import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/presentation/common_screen/auth/controlller/change_password_controller.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_font_family.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_extentions.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/action_button.dart';
import 'package:sumul_hr/widgets/common_text.dart';
import 'package:sumul_hr/widgets/loading.dart';
import 'package:sumul_hr/widgets/text_inputfield.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: authAppBar(context),
      body: body(),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget body() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  logo(),
                  Spacer(),
                  screenTitle(),
                  subTitle(),
                  Gap(Sizer.s20),
                  GetBuilder<ChangePasswordController>(
                    id: "changepassword",

                    builder: (controller) {
                      return form();
                    },
                  ),
                  Gap(Sizer.s40),
                ],
              ),
            ),
          ),
        );
      },
    ).paddingSymmetric(horizontal: Sizer.s20);
  }

  Widget subTitle() {
    return CommonText(
      text: StringConstants.menuchangepasswordcreatenew,
      fontSize: Sizer.s14,
      fontFamily: FontFamilyConstants.poppins,
      fontWeight: PoppinsWeight.regular400.weight,
      color: AppColor.whiteColor,
    );
  }

  Widget logo() {
    return Center(
      child: Image.asset(
        ImageConstants.imgLogo,
        height: Sizer.height(Get.size.height * 0.1),
      ),
    );
  }

  AppBar authAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: Padding(
        padding: Sizer.paddingOnly(top: Sizer.s12),
        child:
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.whiteColor,
            ).onInkTap(() {
              Get.back();
            }),
      ),
    );
  }

  Widget form() {
    return Form(
      key: controller.changePasswordformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          textField(
            textController: controller.passwordController.value,
            hintText: StringConstants.menuchangepasswordoldpassword,
            obsecure: controller.isObscureOld,
            errorMessage: "Please enter valid old password",
          ),
          Gap(Sizer.s10),
          textField(
            textController: controller.newpasswordController.value,
            hintText: StringConstants.menuchangepasswordnewpassword,
            obsecure: controller.isObscureNew,
            errorMessage: "Please enter valid New password",
          ),
          Gap(Sizer.s10),
          textField(
            textController: controller.cnfpasswordController.value,
            hintText: StringConstants.menuchangepasswordnewcnfpassword,
            obsecure: controller.isObscureCnf,
            errorMessage: "Please enter valid Confirm New password",
          ),
          Gap(Sizer.s20),
          actionButton(),
          Gap(Sizer.s6),
        ],
      ),
    );
  }

  Widget actionButton() {
    return controller.isLoading.value
        ? const CommonLoading(color: AppColor.whiteColor)
        : CommonButton(
            fontSize: Sizer.font(Sizer.s20),
            textColor: AppColor.whiteColor,
            gradient: LinearGradient(
              colors: [AppColor.secondaryColor, AppColor.orangeLightColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            text: StringConstants.menuchangepassword.tr,
            onTap: () {
              controller.changePassword();
            },
          );
  }

  Widget textField({
    TextEditingController? textController,
    String? hintText,
    String? errorMessage,
    required RxBool obsecure,
  }) {
    return CommonInputFormField(
      controller: textController ?? TextEditingController(),
      hintText: hintText ?? "",
      obscureText: obsecure.value,
      colorHint: AppColor.mediumBlackColor,

      fontSizeHint: Sizer.font(Sizer.s20),
      keyboardType: TextInputType.number,
      fontWeightHint: FontWeight.w500,
      textColor: AppColor.mediumBlackColor,
      textFontWeight: FontWeight.w500,
      textfontSize: Sizer.font(Sizer.s20),
      onChanged: (p0) {},
      obscureClick: () {
        obsecure.toggle();
        controller.update(["changepassword"]);
      },

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget screenTitle() {
    return CommonText(
      text: StringConstants.menuchangepassword.tr,
      fontSize: Sizer.s24,
      fontFamily: FontFamilyConstants.poppins,
      fontWeight: PoppinsWeight.semiBold600.weight,
      color: AppColor.whiteColor,
    );
  }
}
