import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/controller/dashboard_controller.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/widget/dashboard_widget.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/widget/unread_notification.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/resources/app_text_style.dart';
import 'package:sumul_hr/routes/app_routes.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/appbar.dart';
import 'package:sumul_hr/widgets/exit_app_confirmation_view.dart';
import 'package:sumul_hr/widgets/top_emp_details_view.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent automatic pop
      onPopInvokedWithResult: (popResult, didPop) async {
        final nav = Navigator.of(context);
        final shouldExit = await ExitAppWithPopScopeHelper.onWillPop();

        if (shouldExit) {
          // Only pop if user confirmed exit
          nav.maybePop();
        }
      },
      child: _buildMainContent(),
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      key: controller.scaffoldKey,

      backgroundColor: AppColor.whiteColor,
      appBar: appBar(
        drawerClick: () {
          //controller.toggleDrawer();
          controller.scaffoldKey.currentState?.openEndDrawer();
        },
        isBack: false,
        titleName: StringConstants.appName,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.whiteColor,
        isIcon: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AppServices.settings.listOfDistributor.length == 1
          ? SizedBox.fromSize()
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: Sizer.baseWidth * (Sizer.isTablet ? 0.9 : 0.4),
                  height: Sizer.baseHeight * (Sizer.isTablet ? 0.08 : 0.045),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: Sizer.radius(Sizer.s5),
                  ),

                  child: AllFunction.commonPopinsText(
                    StringConstants.back.tr,
                    color: AppColor.whiteColor,
                    fontWeight: PoppinsWeight.semiBold600,
                    fontSize: Sizer.s12 + 1,
                  ),
                ).onInkTap(() {
                  Get.offNamedUntil(
                    AppServices.settings.isDistributor
                        ? Routes.DIST_CATEGORY_SCREEN
                        : Routes.CATEGORY_SCREEN,
                    (route) => false,
                  );
                }),
              ],
            ),
      endDrawer: const DrawerMenuView(),
      body: Obx(() {
        return Column(
          children: [
            commonTopEmpDetailsView(
              agentCode: AppServices.settings.isDistributor
                  ? AppServices.settings.selectedDistributor
                  : AppServices.settings.selectedAgent,
              agentName: AppServices.settings.isDistributor
                  ? AppServices.settings.name
                  : AppServices.settings.selectedAgentName,
              displayTime: true,
              displayBalance: true,
              isRaunded: true,

              time: controller.currentTime.value,
            ),
            if (AppServices.settings.unreadCount > 0)
              UnreadNotificationAlert(
                message:
                    " ${StringConstants.youhave} ${AppServices.settings.unreadCount} ${StringConstants.newnotifications} ${StringConstants.received}",
                onTap: () {
                  controller.selectMenu(StringConstants.menunewsalert);
                },
              ),

            orderTimeView(),

            menuView(),
          ],
        );
      }),
    );
  }

  Widget menuView() {
    return Expanded(
      child: Obx(() {
        return ListView.separated(
          // padding: const EdgeInsets.all(16),
          padding: Sizer.paddingOnly(
            left: Sizer.s16,
            right: Sizer.s16,
            top: Sizer.s16,
            bottom: Sizer.s60,
          ),
          itemCount: controller.menuGroups.length,
          separatorBuilder: (_, __) => Gap(Sizer.s20),
          itemBuilder: (context, index) {
            final group = controller.menuGroups[index];
            final visibleItems = group.items
                .where((item) => item.isVisible ?? false)
                .toList();
            return AnimatedSize(
              duration: const Duration(milliseconds: 300),

              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => controller.toggleExpansion(index),
                    child: Container(
                      padding: Sizer.paddingOnly(
                        left: 10.r,
                        right: 10.r,
                        top: 10.r,
                        bottom: 10.r,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [AllFunction().commonBoxShadow()],
                        color: AppColor.lightBlueColor,
                        borderRadius: group.isExpanded
                            ? Sizer.radiusOnly(
                                topLeft: Sizer.s10,
                                topRight: Sizer.s10,
                              )
                            : Sizer.radius(Sizer.s10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AllFunction.commonPopinsText(
                            group.titleKey.tr,
                            fontSize: Sizer.font(Sizer.s16),
                            fontWeight: PoppinsWeight.semiBold600,
                            color: AppColor.primaryColor,
                          ),
                          Image.asset(
                            group.isExpanded
                                ? ImageConstants.imgCloseDropDown
                                : ImageConstants.imgPlus,
                            width: Sizer.s16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (group.isExpanded)
                    Transform.translate(
                      offset: Offset(0, -Sizer.s4),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.lightBlueColor,
                            width: 1.5,
                          ),
                          borderRadius: Sizer.radiusOnly(
                            bottomLeft: Sizer.s10,
                            bottomRight: Sizer.s10,
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: visibleItems.length,
                          itemBuilder: (context, itemIndex) {
                            final item = visibleItems[itemIndex];
                            final isLast = itemIndex == visibleItems.length - 1;
                            final isFirstIndex = itemIndex == 0;

                            return (item.isVisible ?? false)
                                ? MenuItemWidget(
                                    item: item,
                                    isFirstIndex: isFirstIndex,
                                    isLast: isLast,
                                  ).onInkTap(() {
                                    controller.selectMenu(item.title);
                                  })
                                : SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget orderTimeView() {
    return (controller.shiftWiseCompletedMessage.isEmpty)
        ? SizedBox.shrink()
        : Container(
            alignment: Alignment.center,
            margin: Sizer.marginOnly(
              left: Sizer.s10,
              right: Sizer.s10,
              top: AppServices.settings.unreadCount > 0 ? 0 : Sizer.s20,
            ),
            padding: Sizer.paddingOnly(
              left: Sizer.s10,
              top: Sizer.s10,
              right: Sizer.s10,
            ),
            decoration: BoxDecoration(
              color: AppColor.lightBlueColor,
              borderRadius: Sizer.radius(Sizer.s12),
              boxShadow: [AllFunction().commonBoxShadow()],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.imgTimeAlert,
                      height: Sizer.s20,
                      width: Sizer.s20,
                    ),

                    Gap(Sizer.s8),
                    Expanded(
                      child: AllFunction.commonPopinsText(
                        textAlign: TextAlign.center,
                        StringConstants.ordertimenotice,
                        fontSize: Sizer.font(
                          Sizer.isTablet ? Sizer.s16 : Sizer.s14,
                        ),
                        fontWeight: PoppinsWeight.bold700,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                Gap(Sizer.s10),

                // Split message into 2 lines manually
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.bold.copyWith(
                        fontSize: Sizer.font(
                          Sizer.isTablet ? Sizer.s14 : Sizer.s12,
                        ),
                        color: AppColor.blueColor,
                      ),
                      children: _buildStyledMessage(
                        controller.shiftWiseCompletedMessage.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  List<TextSpan> _buildStyledMessage(String message) {
    // Extract time using RegExp (e.g., "07:00 AM to 10:00 AM")
    final timeRegex = RegExp(r'(\d{1,2}:\d{2} [AP]M to \d{1,2}:\d{2} [AP]M)');
    final matches = timeRegex.allMatches(message);

    if (matches.isEmpty) {
      return [TextSpan(text: message)];
    }

    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: message.substring(lastIndex, match.start)));
      }

      final timeText = message.substring(match.start, match.end);

      spans.add(
        TextSpan(
          text: "\n $timeText \n",
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < message.length) {
      spans.add(TextSpan(text: message.substring(lastIndex)));
    }

    return spans;
  }
}
