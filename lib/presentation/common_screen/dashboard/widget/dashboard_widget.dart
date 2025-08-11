import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/auth_model.dart';
import 'package:sumul_hr/presentation/common_screen/auth/repository/auth_repository.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/controller/dashboard_controller.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/model/dashboard_model.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/routes/app_routes.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/show_comman_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerMenuView extends StatelessWidget {
  const DrawerMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Drawer(
      elevation: 8.0,
      width: Sizer.baseWidth.w * 0.7,
      backgroundColor: AppColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: Sizer.paddingOnly(
            left: Sizer.s20,
            right: Sizer.s20,
            top: Sizer.s1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuItemWidget(
                item: MenuItem(
                  titleKey: StringConstants.menupricelist,
                  iconPath: ImageConstants.imgPriceList,
                ),
                isFirstIndex: true,
                isLast: false,
              ).onTap(() {
                controller.selectMenu(StringConstants.menupricelist);
              }),
              MenuItemWidget(
                item: MenuItem(
                  titleKey: StringConstants.menunewsalert,
                  iconPath: ImageConstants.imgNewsAlert,
                ),
                isFirstIndex: false,
                isLast: false,
                newscount: AppServices.settings.unreadCount.obs,
              ).onTap(() {
                controller.scaffoldKey.currentState?.closeEndDrawer();
                controller.selectMenu(StringConstants.menunewsalert);
              }),

              MenuItemWidget(
                item: MenuItem(
                  titleKey: StringConstants.menuaboutus,
                  iconPath: ImageConstants.imgAboutUs,
                ),
                isFirstIndex: false,
                isLast: false,
              ).onTap(() {
                controller.selectMenu(StringConstants.menuaboutus);
              }),
              // MenuItemWidget(
              //   item: MenuItem(
              //     titleKey: StringConstants.back,
              //     iconPath:
              //         AppServices.settings.selectedMainCategory.toLowerCase() ==
              //             MainCategoryEnum.milk.name.toLowerCase()
              //         ? ImageConstants.imgMilk
              //         : AppServices.settings.selectedMainCategory
              //                   .toLowerCase() ==
              //               MainCategoryEnum.bakery.name.toLowerCase()
              //         ? ImageConstants.imgBakery
              //         : ImageConstants.imgDairyProduct,
              //   ),
              //   isFirstIndex: false,
              //   isLast: false,
              // ).onTap(() async {
              //   Get.offNamedUntil(Routes.CATEGORY_SCREEN, (route) => false);
              // }),
              MenuItemWidget(
                item: MenuItem(
                  titleKey: StringConstants.menulogoutfromalldevice,
                  iconPath: ImageConstants.imgLogoutS,
                ),
                isFirstIndex: false,
                isLast: false,
              ).onTap(() async {
                try {
                  var sendResponse =
                      await AuthRepository().sendOtpServiceCall(
                        AppServices.settings.mobileNo,
                      ) ??
                      SendOtpResponseModel();

                  if ((sendResponse.status ?? false)) {
                    if (sendResponse.data != null) {
                      Get.toNamed(
                        Routes.OTP_SCREEN,
                        arguments: sendResponse.data,
                      );
                    } else {
                      await Get.dialog(
                        ShowAleartComman(
                          title: StringConstants.alert.capitalized,
                          content:
                              sendResponse.message ??
                              "${StringConstants.noRecordFound} for ${AppServices.settings.isDistributor ? AppServices.settings.selectedDistributor : AppServices.settings.empNo}",
                        ),
                      );
                    }
                  } else {
                    await Get.dialog(
                      ShowAleartComman(
                        title: "Error",
                        content:
                            sendResponse.message ??
                            "No Record found for ${AppServices.settings.isDistributor ? AppServices.settings.selectedDistributor : AppServices.settings.empNo}",
                      ),
                    );
                  }
                } catch (e) {
                  AllFunction.safeLog("ERROR===>>>>${e.toString()}");
                }
              }),
              Gap(Sizer.s10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AllFunction.commonPopinsText(
                    StringConstants.langEnglish,
                    color:
                        (AppServices.settings.languageCode ==
                            StringConstants.langEnglishCode)
                        ? AppColor.secondaryColor
                        : AppColor.primaryColor,

                    fontSize: Sizer.font(Sizer.s14),
                    fontWeight: PoppinsWeight.semiBold600,
                  ).onInkTap(() {
                    AllFunction.changeLanguage(StringConstants.langEnglishCode);
                    controller.update(["updateCount"]);
                    // controller.update(); // if using GetBuilder
                    // controller.menuGroups.refresh(); // for Obx()
                    // Get.forceAppUpdate();
                  }),
                  Gap(Sizer.s10),
                  Container(
                    height: Sizer.s5,
                    width: Sizer.s5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Gap(Sizer.s10),
                  AllFunction.commonPopinsText(
                    StringConstants.langGujrati,
                    color:
                        (AppServices.settings.languageCode ==
                            StringConstants.langGujaratiCode)
                        ? AppColor.secondaryColor
                        : AppColor.primaryColor,

                    fontSize: Sizer.font(Sizer.s14),
                    fontWeight: PoppinsWeight.semiBold600,
                  ).onInkTap(() {
                    AllFunction.changeLanguage(
                      StringConstants.langGujaratiCode,
                    );

                    // controller.update(); // if using GetBuilder
                    // controller.menuGroups.refresh(); // for Obx()
                    // Get.forceAppUpdate();
                  }),
                  Gap(Sizer.s10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor,
                    ),
                    height: Sizer.s5,
                    width: Sizer.s5,
                  ),
                  Gap(Sizer.s10),
                  AllFunction.commonPopinsText(
                    StringConstants.langHindi,
                    color:
                        (AppServices.settings.languageCode ==
                            StringConstants.langHindiCode)
                        ? AppColor.secondaryColor
                        : AppColor.primaryColor,
                    fontSize: Sizer.font(Sizer.s14),
                    fontWeight: PoppinsWeight.semiBold600,
                  ).onInkTap(() {
                    AllFunction.changeLanguage(StringConstants.langHindiCode);
                    // controller.update(); // if using GetBuilder
                    // controller.menuGroups.refresh(); // for Obx()
                    // Get.forceAppUpdate();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.item,
    required this.isFirstIndex,
    required this.isLast,
    this.newscount,
  });

  final MenuItem item;
  final bool isFirstIndex;
  final bool isLast;
  final RxInt? newscount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        children: [
          Image.asset(
            item.iconPath,
            width: 22,
            height: 22,
            fit: BoxFit.contain,
          ).paddingOnly(top: isFirstIndex ? Sizer.s10 : 0),
          Gap(Sizer.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(isFirstIndex ? Sizer.s20 : Sizer.s10),
                AllFunction.commonPopinsText(
                  item.title.tr,
                  fontSize: Sizer.font(Sizer.s14),
                  fontWeight: PoppinsWeight.medium500,
                  color: AppColor.mediumBlackColor,
                ),
                Gap(Sizer.s10),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.lightGreyColor,
                  ),
              ],
            ),
          ),
          if (item.title == StringConstants.menunewsalert &&
              ((newscount?.value ?? 0) > 0))
            GetBuilder<DashboardController>(
              id: "updateCount",
              builder: (controller) {
                return CircleAvatar(
                  backgroundColor: AppColor.secondaryColor,
                  radius: Sizer.s14,
                  child: AllFunction.commonPopinsText(
                    "${newscount?.value ?? 0}",
                    color: AppColor.whiteColor,
                    fontWeight: PoppinsWeight.bold700,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
