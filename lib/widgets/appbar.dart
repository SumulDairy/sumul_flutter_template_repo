// AppBar

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/routes/app_routes.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/common/functions.dart';

import 'package:velocity_x/velocity_x.dart';

AppBar appBar({
  String? titleName,
  Function()? onTap,
  Color? backgroundColor,
  isIcon = false,
  isBack = false,
  Widget? actionWidget,
  Function()? drawerClick,
  textColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? AppColor.whiteColor,
    automaticallyImplyLeading: false,
    leadingWidth: isBack ? Sizer.s40 : Sizer.s50.h,
    leading: appbarLead(
      onTap,
      textColor,
      isBack,
    ).paddingOnly(top: Sizer.s10, left: Sizer.s10),
    toolbarHeight: Get.size.height.h * 0.05,

    title: appbarTitle(titleName, textColor),
    centerTitle: true,
    actions: [actionMenu(isIcon, drawerClick)],
    actionsIconTheme: IconThemeData(color: AppColor.whiteColor),
    // elevation: 0.0,
  );
}

Widget appbarTitle(String? titleName, textColor) {
  return AllFunction.commonPopinsText(
    titleName ?? "",
    color: textColor,
    fontSize: Sizer.font(Sizer.s20),
    fontWeight: PoppinsWeight.semiBold600,
  );
}

Widget appbarLead(void Function()? onTap, textColor, isBack) {
  return InkWell(
    onTap: onTap,
    child: isBack
        ? Image.asset(
            ImageConstants.imgBackArrow,
            color: textColor ?? AppColor.blackColor,
            cacheHeight: 20,
          ).onInkTap(() {
            Get.back();
          })
        : Image.asset(ImageConstants.imgLogo, height: Sizer.height(Sizer.s60)),
  );
}

Widget actionMenu(isIcon, Function()? drawerClick) {
  return isIcon
      ? Image.asset(ImageConstants.imgHambergerMenu, cacheHeight: 20)
            .onInkTap(() {
              if (drawerClick != null) {
                drawerClick(); // ✅ this toggles drawer
              }
            })
            .marginOnly(right: Sizer.s10)
      : const SizedBox();
}

void moreSelectionClick(String value) {
  switch (value) {
    case "setting":
      settingsClick();
      break;
    case "logout":
      logoutClick();
      break;
    default:
  }
}

void settingsClick() {}

void logoutClick() {
  AppServices.settings.selectedAgent = "";
  AppServices.settings.selectedMainCategory = "";
  Get.offNamedUntil(
    Routes.CATEGORY_SCREEN,
    (route) => false, // predicate
  );
}

PopupMenuItem<String> moreMenuItem({String? title, void Function()? onTap}) {
  return PopupMenuItem<String>(
    value: title?.toLowerCase(),
    onTap: onTap,
    child: AllFunction.commonPopinsText(title?.firstLetterUpperCase() ?? ""),
  );
}
