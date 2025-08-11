import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:sumul_hr/widgets/action_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonBottomSummaryBar extends StatelessWidget {
  final List<SummaryRowData>? summaryRows;
  final String? singleLabel;
  final String? singleValue;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool showDivider;
  final Color? btnColor;
  final bool? isLogout;
  final bool? isButton;
  final bool? isRuppe;

  const CommonBottomSummaryBar({
    super.key,
    this.summaryRows,
    this.singleLabel,
    this.singleValue,
    this.buttonText,
    this.onPressed,
    this.showDivider = true,
    this.btnColor,
    this.isLogout,
    this.isButton = true,
    this.isRuppe = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasMultipleSummary = summaryRows != null && summaryRows!.isNotEmpty;
    final hasSingleSummary = singleLabel != null && singleValue != null;

    return (isLogout ?? false)
        ? CommonButton(
            text: (buttonText ?? "").toString().upperCamelCase,
            textColor: AppColor.whiteColor,
            backgroundColor: btnColor ?? AppColor.secondaryColor,
            borderRadius: Sizer.s10,
            onTap: onPressed ?? () {},
            img: ImageConstants.imgLogoutS,
          )
        : Container(
            width: double.infinity,
            padding: Sizer.paddingAll(Sizer.s20),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColor.lightBlackColor.withValues(alpha: .08),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (hasMultipleSummary)
                  ...summaryRows!.map(
                    (row) => Padding(
                      padding: Sizer.paddingSymmetric(
                        horizontal: Sizer.s20,
                        vertical: Sizer.s4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AllFunction.commonPopinsText(
                              row.label,

                              fontSize: Sizer.font(Sizer.s14),
                              fontWeight: PoppinsWeight.semiBold600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: row.values
                                .map(
                                  (v) => Padding(
                                    padding: EdgeInsets.only(left: Sizer.s32),
                                    child: AllFunction.commonPopinsText(
                                      v,
                                      fontSize: Sizer.font(Sizer.s14),
                                      fontWeight: PoppinsWeight.semiBold600,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (!hasMultipleSummary && hasSingleSummary)
                  Padding(
                    padding: Sizer.paddingSymmetric(horizontal: Sizer.s20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AllFunction.commonPopinsText(
                            singleLabel!,
                            fontSize: Sizer.font(Sizer.s16),
                            fontWeight: PoppinsWeight.semiBold600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        AllFunction.commonPopinsText(
                          isRuppe == true
                              ? "₹${singleValue.toString()}"
                              : singleValue.toString(),
                          color: AppColor.mediumBlackColor,
                          fontSize: Sizer.font(Sizer.s16),
                          fontWeight: PoppinsWeight.semiBold600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                if (hasMultipleSummary || hasSingleSummary) Gap(Sizer.s10),

                if (showDivider && (hasMultipleSummary || hasSingleSummary))
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.lightGreyColor,
                  ),

                if (hasMultipleSummary || hasSingleSummary) Gap(Sizer.s16),

                if (isButton ?? false)
                  CommonButton(
                    text: buttonText ?? "",
                    textColor: AppColor.whiteColor,
                    backgroundColor: btnColor ?? AppColor.secondaryColor,
                    borderRadius: Sizer.s10,
                    onTap: onPressed ?? () {},
                  ),
              ],
            ),
          );
  }

  /// Removes all non-digit characters and converts to int
  int sanitizeToInt(String? value) {
    final cleaned = value?.replaceAll(RegExp(r'[^\d]'), '') ?? '0';
    return int.tryParse(cleaned) ?? 0;
  }
}

/// Model for dynamic row label + multiple values
class SummaryRowData {
  final String label;
  final List<String> values;

  SummaryRowData({required this.label, required this.values});
}
