import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/presentation/common_screen/auth/controlller/auth_controlle.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_font_family.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_extentions.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/action_button.dart';
import 'package:sumul_hr/widgets/common_text.dart';
import 'package:sumul_hr/widgets/loading.dart' show CommonLoading;
import 'package:sumul_hr/widgets/text_inputfield.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  logo(),
                  Spacer(),
                  sendOtpBody(),
                  Gap(Sizer.s40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget logo() {
    return Image.asset(
      ImageConstants.imgLogo,
      height: Sizer.height(Get.size.height * 0.1),
    );
  }

  Widget sendOtpBody() {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          screenTitle(),
          Gap(Sizer.s6),

          sendOtpSubTitle(),
          Gap(Sizer.height(Sizer.s20)),

          form(),
        ],
      ).paddingSymmetric(horizontal: Sizer.width(Sizer.s20));
    });
  }

  Widget form() {
    return Form(
      key: controller.authformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          empCodeField(),

          Gap(Sizer.s10),
          actionButton(),
          Gap(Sizer.s6),
        ],
      ),
    );
  }

  Widget resendText() {
    return Align(
      alignment: Alignment.centerRight,
      child:
          CommonText(
            textAlign: TextAlign.right,
            text: StringConstants.loginScreenResendOtpText,
            fontSize: Sizer.s18,
            fontFamily: FontFamilyConstants.poppins,
            fontWeight: PoppinsWeight.semiBold600.weight,
            color: AppColor.secondaryColor,
          ).onInkTap(() {
            // controller?.sendOtp();
          }),
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
            text: StringConstants.loginScreenLoginText,
            onTap: () {
              controller.sendOtpClick();
            },
          );
  }

  Widget empCodeField() {
    return CommonInputFormField(
      controller: controller.usernameController.value,
      hintText: StringConstants.loginScreenHintMobileNumber,
      obscureText: false,
      colorHint: AppColor.mediumBlackColor,

      fontSizeHint: Sizer.font(Sizer.s20),
      keyboardType: TextInputType.number,
      fontWeightHint: FontWeight.w500,
      textColor: AppColor.mediumBlackColor,
      textFontWeight: FontWeight.w500,
      textfontSize: Sizer.font(Sizer.s20),
      onChanged: (p0) {},
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return StringConstants.loginScreenPleaseEnterUsername;
        }
        return null;
      },
    );
  }

  Widget screenTitle() {
    return CommonText(
      text: StringConstants.loginScreenLoginText,
      fontSize: Sizer.s24,
      fontFamily: FontFamilyConstants.poppins,
      fontWeight: PoppinsWeight.semiBold600.weight,
      color: AppColor.whiteColor,
    );
  }

  Widget sendOtpSubTitle() {
    return CommonText(
      text: StringConstants.loginScreenEnterMobileNumber,
      fontSize: Sizer.s16,
      fontFamily: FontFamilyConstants.poppins,
      fontWeight: PoppinsWeight.regular400.weight,
      color: AppColor.whiteColor,
    );
  }

  Widget verifyOtpSubTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: StringConstants.loginScreenSmsSentMessage,
          fontSize: Sizer.s16,
          fontFamily: FontFamilyConstants.poppins,
          fontWeight: PoppinsWeight.regular400.weight,
          color: AppColor.whiteColor,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Sizer.s18,
              fontFamily: FontFamilyConstants.poppins,
              fontWeight: PoppinsWeight.semiBold600.weight,
              color: AppColor.lightHighlihgtBlueColor,
            ),
            children: [
              TextSpan(text: "${controller.sendResponseData.mobileno}"),
              TextSpan(
                text: " ${StringConstants.loginScreenChange}",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.back();
                  },
                style: TextStyle(
                  fontSize: Sizer.s18,
                  fontFamily: FontFamilyConstants.poppins,
                  fontWeight: PoppinsWeight.semiBold600.weight,
                  color: AppColor.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
