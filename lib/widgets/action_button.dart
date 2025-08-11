import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_extentions.dart';
import 'package:sumul_hr/resources/app_font_family.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/common_text.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? verticalPadding;
  final double? borderRadius;
  final String? fontFamily;
  final bool? isBoarder;
  final Color? borderColor;
  final double? horizontalPadding;
  final Gradient? gradient; // ✅ NEW
  final bool? isGradient;
  final String? img;

  const CommonButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.verticalPadding,
    this.borderRadius,
    this.fontFamily,
    this.isBoarder,
    this.borderColor,
    this.horizontalPadding,
    this.gradient, // ✅ NEW
    this.isGradient,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Sizer.radius(borderRadius ?? Sizer.s16);

    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          alignment: Alignment.center,
          padding: Sizer.paddingSymmetric(
            vertical: verticalPadding ?? Sizer.s10,
            horizontal: horizontalPadding ?? 0,
          ),
          decoration: BoxDecoration(
            gradient:
                gradient ??
                (isGradient == true
                    ? LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColor.secondaryColor,
                          AppColor.orangeLightColor,
                        ],
                        stops: [0.0083, 1.0],
                      )
                    : null), // ✅ Apply gradient if provided
            color: isGradient == false
                ? (backgroundColor ?? AppColor.primaryColor)
                : null,
            borderRadius: radius,
            border: Border.all(
              color: isBoarder == true
                  ? borderColor ?? AppColor.blackColor
                  : AppColor.transparentColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: text.firstLetterUpperCase(),
                fontSize: Sizer.font(fontSize ?? Sizer.s16),
                color:
                    textColor ??
                    (Get.isDarkMode
                        ? AppColor.whiteColor
                        : AppColor.blackColor),
                fontFamily: fontFamily ?? FontFamilyConstants.poppins,
                fontWeight: fontWeight ?? PoppinsWeight.bold700.weight,
              ),
              if (!AllFunction.isStringNullOrEmptyOrBlank(img ?? ""))
                Image.asset(
                  img ?? "",
                  color: AppColor.whiteColor,
                ).marginOnly(left: Sizer.s10),
            ],
          ),
        ),
      ),
    );
  }
}
