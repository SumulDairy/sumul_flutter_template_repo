import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/di/di_helper_services.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/resources/app_string.dart';

Widget commonTopEmpDetailsView({bool? isRaunded}) {
  return Container(
    padding: Sizer.paddingOnly(
      bottom: Sizer.s10,
      top: Sizer.s10,
      left: Sizer.s10,
      right: Sizer.s10,
    ),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColor.lightBlueColor,
      borderRadius: (isRaunded ?? false)
          ? Sizer.radiusOnly(bottomLeft: Sizer.s20, bottomRight: Sizer.s20)
          : Sizer.radius(0),
      boxShadow: [AllFunction().commonBoxShadow()],
    ),
    child: Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: infoColumn(
                  "",
                  AppServices.settings.name,
                  isExpanded: true,
                  fontWeight: PoppinsWeight.semiBold600,
                  fontSize: Sizer.font(Sizer.s14),
                ),
              ),

              infoRow(
                StringConstants.formEmpNo,
                AppServices.settings.empNo,
                isExpanded: false,
                fontSize: Sizer.font(Sizer.s12),
                fontWeight: PoppinsWeight.bold700,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget infoColumn(
  String? label,
  String value, {
  bool isExpanded = false,
  PoppinsWeight? fontWeight,
  double? fontSize,
  bool? isCenter,
  Color? balanceColor = AppColor.mediumBlackColor,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: (isCenter ?? false)
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start,
    children: [
      if (!AllFunction.isStringNullOrEmptyOrBlank(label ?? ""))
        AllFunction.commonPopinsText(
          label ?? "",
          maxLines: 1,

          overflow: isExpanded ? TextOverflow.ellipsis : null,
          fontSize: fontSize ?? Sizer.font(Sizer.s12),
          fontWeight: fontWeight ?? PoppinsWeight.regular400,
          color: balanceColor ?? AppColor.mediumBlackColor,
        ),
      AllFunction.commonPopinsText(
        value,
        maxLines: 1,

        overflow: isExpanded ? TextOverflow.ellipsis : null,
        fontSize: fontSize ?? Sizer.font(Sizer.s12),
        fontWeight: fontWeight ?? PoppinsWeight.regular400,
        color: balanceColor ?? AppColor.mediumBlackColor,
      ),
    ],
  );
}

Widget infoColumn2(
  String? label,
  String value, {
  bool isExpanded = false,
  PoppinsWeight? fontWeight,
  double? fontSize,
  bool? isCenter,
  Color? balanceColor = AppColor.mediumBlackColor,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: (isCenter ?? false)
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start,
    children: [
      if (!AllFunction.isStringNullOrEmptyOrBlank(label ?? ""))
        AllFunction.commonPopinsText(
          label ?? "",
          maxLines: 1,

          overflow: isExpanded ? TextOverflow.ellipsis : null,
          fontSize: fontSize ?? Sizer.font(Sizer.s12),
          fontWeight: fontWeight ?? PoppinsWeight.regular400,
          color: balanceColor ?? AppColor.mediumBlackColor,
        ),
      AllFunction.commonPopinsText(
        value,
        maxLines: 1,

        overflow: isExpanded ? TextOverflow.ellipsis : null,
        fontSize: fontSize ?? Sizer.font(Sizer.s12),
        fontWeight: fontWeight ?? PoppinsWeight.regular400,
        color: balanceColor ?? AppColor.mediumBlackColor,
      ),
    ],
  );
}

Widget infoRow(
  String? label,
  String value, {
  bool isExpanded = false,
  PoppinsWeight? fontWeight,
  double? fontSize,
  bool? isBalanceVisible = false,
  bool? isNegative,
}) {
  isNegative = (double.tryParse(AppServices.settings.agentBalance) ?? 0) <= 0;
  return Container(
    padding: Sizer.paddingSymmetric(horizontal: Sizer.s20, vertical: Sizer.s5),

    decoration: BoxDecoration(
      boxShadow: [AllFunction().commonBoxShadow()],
      borderRadius: Sizer.radius(Sizer.s5),
      color: (isBalanceVisible ?? false)
          ? (isNegative)
                ? AppColor.errorColor
                : AppColor.orangeExtraLightColor
          : AppColor.whiteColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AllFunction.commonPopinsText(
          label ?? "",
          maxLines: 1,

          overflow: isExpanded ? TextOverflow.ellipsis : null,
          fontSize: fontSize ?? Sizer.font(Sizer.s12),
          fontWeight: PoppinsWeight.regular400,
          color: (isBalanceVisible ?? false)
              ? (isNegative)
                    ? AppColor.whiteColor
                    : AppColor.mediumBlackColor
              : AppColor.mediumBlackColor,
        ),
        Gap(Sizer.s10),
        AllFunction.commonPopinsText(
          ":",
          maxLines: 1,

          overflow: isExpanded ? TextOverflow.ellipsis : null,
          fontSize: fontSize ?? Sizer.font(Sizer.s12),
          fontWeight: fontWeight ?? PoppinsWeight.regular400,
          color: (isBalanceVisible ?? false)
              ? (isNegative)
                    ? AppColor.whiteColor
                    : AppColor.mediumBlackColor
              : AppColor.mediumBlackColor,
        ),
        Gap(Sizer.s10),
        AllFunction.commonPopinsText(
          value,
          maxLines: 1,
          overflow: isExpanded ? TextOverflow.ellipsis : null,
          fontSize: fontSize ?? Sizer.font(Sizer.s12),
          fontWeight: fontWeight ?? PoppinsWeight.regular400,
          color: (isBalanceVisible ?? false)
              ? (isNegative)
                    ? AppColor.whiteColor
                    : AppColor.mediumBlackColor
              : AppColor.mediumBlackColor,
        ),
      ],
    ),
  );
}
