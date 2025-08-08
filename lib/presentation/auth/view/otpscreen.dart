import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sumul_transport/presentation/auth/controlller/otp_controller.dart';
import 'package:sumul_transport/presentation/auth/repository/auth_repository.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/resources/app_image_assets.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_extentions.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/widgets/action_button.dart';
import 'package:sumul_transport/widgets/common_text.dart';
import 'package:sumul_transport/widgets/loading.dart';
import 'package:velocity_x/velocity_x.dart';

class Otpscreen extends GetView<OtpController> {
  const Otpscreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  logo(),
                  Spacer(),
                  sendOtpBody(context),
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

  AppBar authAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      toolbarHeight: Sizer.height(Sizer.s32),
      leading: Padding(
        padding: Sizer.paddingOnly(top: Sizer.s12),
        child:
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.whiteColor,
            ).onInkTap(() {
              controller.back();
            }),
      ),
    );
  }

  Widget sendOtpBody(context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          screenTitle(),
          Gap(Sizer.s6),
          verifyOtpSubTitle(),
          Gap(Sizer.height(Sizer.s20)),

          form(context),
        ],
      ).paddingSymmetric(horizontal: Sizer.width(Sizer.s20));
    });
  }

  Widget form(context) {
    return Form(
      key: controller.otpformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PinCodeTextField(
            appContext: context,
            length: 4,
            onChanged: (value) => controller.otpCode.value = value,
            keyboardType: TextInputType.number,
            backgroundColor:
                AppColor.transparentColor, //  Force white background
            enableActiveFill: true, //  Ensure fill colors apply
            // boxShadows: const [], //  Remove all shadows
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // optional, can be start
            autoFocus: false,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: Sizer.font(Sizer.s72),
              fieldWidth: Sizer.font(Sizer.s72),
              borderWidth: 0,
              activeFillColor: AppColor.whiteColor,
              selectedFillColor: AppColor.whiteColor,
              inactiveFillColor: AppColor.whiteColor,
              activeColor: AppColor.transparentColor,
              selectedColor: AppColor.transparentColor,
              inactiveColor: AppColor.transparentColor,
            ),
          ),
          Gap(Sizer.s10),
          resendText(),
          Gap(Sizer.s20),
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
            AuthRepository().sendOtpServiceCall(
              controller.sendResponseData.mobileno ?? "",
            );
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
            text: StringConstants.loginScreenVerifyOtpText,
            onTap: () {
              controller.verifyOtpClick();
            },
          );
  }

  Widget screenTitle() {
    return CommonText(
      text: StringConstants.loginScreenVerifyOtpText,

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
              TextSpan(text: controller.sendResponseData.mobileno),
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
