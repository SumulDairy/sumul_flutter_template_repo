import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/widget/dashboard_widget.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/aboutus/controller/aboutus_controller.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/appbar.dart';
import 'package:sumul_hr/widgets/top_emp_details_view.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutusView extends GetView<AboutusController> {
  const AboutusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColor.whiteColor,
      endDrawer: const DrawerMenuView(),
      appBar: appBar(
        drawerClick: () => controller.scaffoldKey.currentState?.openEndDrawer(),
        titleName: StringConstants.menuaboutus.tr,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.whiteColor,
        isBack: true,
        isIcon: true,
      ),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            commonTopEmpDetailsView(
              agentCode: AppServices.settings.isDistributor
                  ? AppServices.settings.selectedDistributor
                  : AppServices.settings.selectedAgent,
              agentName: AppServices.settings.selectedAgentName,
              isRaunded: true,
              displayBalance: true,
              displayTime: true,
            ),
            Spacer(),
            Container(
              padding: Sizer.paddingAll(Sizer.s20),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(Sizer.s24),
                // boxShadow: [AllFunction().commonBoxShadow()],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.support_agent,
                    color: AppColor.primaryColor,
                    size: Sizer.s40,
                  ),
                  SizedBox(height: Sizer.s16),
                  AllFunction.commonPopinsText(
                    (controller.aboutUsResponse.value.lbl ?? ""),
                    textAlign: TextAlign.center,
                    fontSize: Sizer.s20,
                    fontWeight: PoppinsWeight.bold700,
                    color: AppColor.primaryColor,
                  ),
                  // SizedBox(height: Sizer.s12),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Icon(
                  //       Icons.access_time,
                  //       color: AppColor.greyColor,
                  //       size: Sizer.s18,
                  //     ),
                  //     SizedBox(width: Sizer.s6),
                  //     AllFunction.commonPopinsText(
                  //       "(7:00 AM to 5:00 PM)",
                  //       fontSize: Sizer.s16,
                  //       fontWeight: PoppinsWeight.medium500,
                  //       color: AppColor.greyColor,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: Sizer.s12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColor.errorColor,
                            size: Sizer.s20,
                          ),
                          SizedBox(width: Sizer.s6),
                          AllFunction.commonPopinsText(
                            controller
                                    .aboutUsResponse
                                    .value
                                    .data?[index]
                                    .phoneno ??
                                "",
                            fontSize: Sizer.s18,
                            fontWeight: PoppinsWeight.bold700,
                            color: AppColor.secondaryColor,
                          ),
                        ],
                      ).onInkTap(() {
                        controller.makeCall(
                          number:
                              controller
                                  .aboutUsResponse
                                  .value
                                  .data?[index]
                                  .phoneno ??
                              "",
                        );
                      });
                    },
                    separatorBuilder: (context, index) {
                      return Gap(Sizer.s6);
                    },
                    itemCount:
                        controller.aboutUsResponse.value.data?.length ?? 0,
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        );
      }),
    );
  }
}
