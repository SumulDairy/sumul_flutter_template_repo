import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/widget/dashboard_widget.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/newsalert/controller/notification_controller.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/services/file_download_service/filedownload.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/appbar.dart';
import 'package:sumul_hr/widgets/top_emp_details_view.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColor.whiteColor,
      endDrawer: const DrawerMenuView(),
      appBar: appBar(
        drawerClick: () => controller.scaffoldKey.currentState?.openEndDrawer(),
        titleName: StringConstants.menunewsalert.tr,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.whiteColor,
        isBack: true,
        isIcon: true,
      ),
      body: Column(
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
          Expanded(
            child: Obx(() {
              return ListView.separated(
                padding: Sizer.paddingAll(Sizer.s20),
                itemCount: controller.newsList.length,
                separatorBuilder: (_, __) => Gap(Sizer.s10),
                itemBuilder: (context, index) {
                  AllFunction.safeLog(
                    "Count Unread ${controller.unReadCount.value}",
                  );
                  final news = controller.newsList[index];
                  // final isExpanded = controller.expandedList[index];

                  return AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AllFunction.commonPopinsText("${controller.unReadCount.value}"),
                        GestureDetector(
                          onTap: () => controller.toggleExpanded(news),
                          child: Container(
                            padding: Sizer.paddingAll(Sizer.s12),
                            decoration: BoxDecoration(
                              boxShadow: [AllFunction().commonBoxShadow()],
                              color: AppColor.lightBlueColor,
                              borderRadius: (news.isExpanded ?? false)
                                  ? Sizer.radiusOnly(
                                      topLeft: Sizer.s10,
                                      topRight: Sizer.s10,
                                    )
                                  : Sizer.radius(Sizer.s10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AllFunction.commonPopinsText(
                                    news.subject ?? "",
                                    fontSize: Sizer.font(Sizer.s16),
                                    fontWeight: PoppinsWeight.semiBold600,
                                    color: AppColor.primaryColor,
                                  ),
                                ),

                                if (news.msgStatus?.toLowerCase() == "u")
                                  Icon(
                                    Icons.notifications_active_sharp,
                                    color: AppColor.secondaryColor,
                                  ),
                                if (news.msgStatus?.toLowerCase() == "u")
                                  Gap(Sizer.s10),
                                Image.asset(
                                  (news.isExpanded ?? false)
                                      ? ImageConstants.imgCloseDropDown
                                      : ImageConstants.imgPlus,
                                  width: Sizer.s16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        (news.isExpanded ?? false)
                            ? Transform.translate(
                                offset: Offset(0, -Sizer.s4),
                                child: Container(
                                  padding: Sizer.paddingAll(Sizer.s12),
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    border: Border.all(
                                      color: AppColor.lightBlueColor,
                                      width: 1.5,
                                    ),
                                    borderRadius: Sizer.radiusOnly(
                                      bottomLeft: Sizer.s10,
                                      bottomRight: Sizer.s10,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AllFunction.commonPopinsText(
                                        news.message ?? "",
                                        fontSize: Sizer.font(Sizer.s14),
                                        color: AppColor.mediumBlackColor,
                                        fontWeight: PoppinsWeight.medium500,
                                      ),
                                      Gap(Sizer.s10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (!(AllFunction.isStringNullOrEmptyOrBlank(
                                            news.pdfFile ?? "",
                                          )))
                                            TextButton.icon(
                                              icon: const Icon(
                                                Icons.link,
                                                color: AppColor.blueColor,
                                              ),
                                              label:
                                                  AllFunction.commonPopinsText(
                                                    "View",
                                                    fontSize: Sizer.s16,
                                                    fontWeight: PoppinsWeight
                                                        .semiBold600,
                                                    color: AppColor.blueColor,
                                                  ),
                                              onPressed: () {
                                                convertBase64ToPDF(
                                                  news.pdfFile ?? "",
                                                  news.subject?.replaceAll(
                                                        ' ',
                                                        '',
                                                      ) ??
                                                      "",
                                                  isOpen: true,
                                                );
                                              },
                                            ),
                                          // if (news.url != null)
                                          //   TextButton.icon(
                                          //     icon: const Icon(
                                          //       Icons.download,
                                          //       color: AppColor.secondaryColor,
                                          //     ),
                                          //     label: AllFunction.commonPopinsText(
                                          //       "Download",
                                          //       fontSize: Sizer.s16,
                                          //       fontWeight:
                                          //           PoppinsWeight.semiBold600,
                                          //       color: AppColor.secondaryColor,
                                          //     ),
                                          //     onPressed: () =>
                                          //         convertBase64ToPDF(
                                          //           news.pdfFile,
                                          //           news.subject?.replaceAll(' ', '') ?? "",
                                          //           isOpen: true,

                                          //         ),
                                          //   ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
