import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/presentation/create_balance/model/crate_balance_model.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/widgets/appbar.dart';
import 'package:sumul_transport/widgets/exit_app_confirmation_view.dart';
import 'package:sumul_transport/widgets/search_field.dart';
import 'package:sumul_transport/widgets/top_emp_details_view.dart';
import 'package:sumul_transport/presentation/dashboard/controller/dashboard_controller.dart';
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
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(
        isBack: false,
        titleName: StringConstants.appName,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.whiteColor,
        isIcon: true,
      ),

      body: Obx(() {
        return Column(
          children: [
            commonTopEmpDetailsView(isRaunded: true),
            Gap(Sizer.s10),
            Container(
              margin: Sizer.marginOnly(top: Sizer.s16),
              alignment: Alignment.center,
              padding: Sizer.paddingOnly(
                top: Sizer.s5,
                bottom: Sizer.s5,
                left: Sizer.s10,

                right: Sizer.s10,
              ),
              decoration: BoxDecoration(
                color: AppColor.lightHighlihgtBlueColor,
                borderRadius: Sizer.radius(Sizer.s10),
              ),
              child: CommonSearchField(
                fillColor: AppColor.whiteColor,
                controller: controller.monthController,
                isFilled: true,
                isReadOnly: true,
                onItemSelected: (selected) {
                  final formatted = selected.searchKey
                      .toUpperCase(); // 🔥 Convert here
                  controller.selectedMonth.value = formatted;
                  controller.monthController.text = formatted;
                },
                isSuffix: true,
                removeClose: true,

                suggestions: AllFunction.getLastTwoMonths(),
                hintText: controller.selectedMonth.value,
              ),
            ),
            Expanded(
              child: Container(
                margin: Sizer.marginOnly(top: Sizer.s16),
                alignment: Alignment.center,
                padding: Sizer.paddingOnly(
                  top: Sizer.s10,
                  bottom: Sizer.s5,
                  left: Sizer.s10,

                  right: Sizer.s10,
                ),
                decoration: BoxDecoration(
                  color: AppColor.lightBlueColor.withValues(alpha: 0.5),
                  borderRadius: Sizer.radiusOnly(
                    topLeft: Sizer.s10,
                    topRight: Sizer.s10,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AllFunction.commonPopinsText(
                          "Trans CD	",
                          color: AppColor.primaryColor,
                          fontSize: Sizer.font(Sizer.s12 + 1),
                          fontWeight: PoppinsWeight.extraBold800,
                        ),
                        Gap(Sizer.s10),
                        AllFunction.commonPopinsText(
                          "Vehicle No",
                          color: AppColor.primaryColor,
                          fontSize: Sizer.font(Sizer.s12 + 1),
                          fontWeight: PoppinsWeight.extraBold800,
                        ),
                      ],
                    ),
                    Gap(Sizer.s10),
                    Divider(
                      height: 1,
                      thickness: 2,
                      color: AppColor.lightHighlihgtBlueColor,
                    ),

                    Gap(Sizer.s10),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: Sizer.paddingAll(0),
                        itemCount: controller.transportList.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            thickness: 2,
                            color: AppColor.lightHighlihgtBlueColor,
                          ).marginAll(Sizer.s10);
                        },
                        itemBuilder: (context, index) {
                          final row = controller.transportList[index];

                          return buildDataRowHeader(row);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(Sizer.s10),
          ],
        ).paddingSymmetric(horizontal: Sizer.s10);
      }),
    );
  }

  Widget buildDataRowHeader(CrateTransportResponseData? row) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.lightBlueColor,
        borderRadius: Sizer.radius(Sizer.s10),
      ),
      // padding: Sizer.paddingAll(Sizer.s5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildValueCellTransoport(
            row,
            value: "Crate",
            AppColor.whiteColor,
            isRadius: true,
          ),
          Gap(Sizer.s10),
          buildValueCellTransoport(
            row,
            value: "Ledger",
            AppColor.whiteColor,
            isRadius: true,
          ),
          Gap(Sizer.s10),
          buildValueCellTransoport(
            row,
            value: "C/D",
            AppColor.whiteColor,
            isRadius: true,
          ),
          buildValueCellTransoport(
            row,
            AppColor.whiteColor,
            isRadius: false,
            value: row?.transporter,
          ),

          buildValueCellTransoport(
            row,
            value: row?.vehicle,
            AppColor.whiteColor,
            isRadius: false,
          ),
        ],
      ),
    );
  }

  Widget buildValueCellTransoport(
    CrateTransportResponseData? model,
    Color color, {
    String? value,
    bool isRadius = false,
  }) {
    return Expanded(
      child:
          Container(
            padding: Sizer.paddingOnly(top: Sizer.s5, bottom: Sizer.s5),
            decoration: BoxDecoration(
              color: isRadius
                  ? AppColor.secondaryColor.withValues(alpha: 0.5)
                  : AppColor.lightBlueColor,
              borderRadius: Sizer.radius(isRadius ? Sizer.s10 : 0),
              border: Border.all(
                width: 1,
                color: isRadius
                    ? AppColor.secondaryColor
                    : color.withValues(alpha: .5),
              ),
            ),
            child: AllFunction.commonPopinsText(
              value ?? "",
              color: isRadius
                  ? AppColor.mediumBlackColor
                  : AppColor.mediumBlackColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: Sizer.font(isRadius ? Sizer.s12 : Sizer.s14),
              textAlign: TextAlign.center,
              fontWeight: isRadius
                  ? PoppinsWeight.extraBold800
                  : PoppinsWeight.semiBold600,
            ),
          ).onInkTap(() {
            controller.showData(
              selectedType: value,
              model: model ?? CrateTransportResponseData(),
            );
          }),
    );
  }
}
