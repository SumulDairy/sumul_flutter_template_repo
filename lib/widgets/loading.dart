import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/common/functions.dart';

class CommonLoading extends StatelessWidget {
  final Color? color;
  final double? size;

  const CommonLoading({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: color ?? AppColor.primaryColor,
        size: size ?? Sizer.s50,
      ),
    );
  }
}

void showSavingLoader({String message = "Saving..."}) {
  Get.dialog(
    Center(
      child: Container(
        padding: Sizer.paddingAll(Sizer.s24),
        margin: Sizer.paddingSymmetric(horizontal: Sizer.s40),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitCircle(color: AppColor.orangeLightColor, size: Sizer.s64),
            if (!AllFunction.isStringNullOrEmptyOrBlank(message))
              Gap(Sizer.s10),
            if (!AllFunction.isStringNullOrEmptyOrBlank(message))
              AllFunction.commonPopinsText(
                message,
                textAlign: TextAlign.left,
                fontSize: Sizer.s18,
                fontWeight: PoppinsWeight.medium500,

                color: AppColor.primaryColor,
              ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.3), // Soft blur background
  );
}

void hideSavingLoader() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
