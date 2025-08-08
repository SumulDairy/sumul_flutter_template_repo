import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/widgets/action_button.dart';

class ShowAleartComman extends StatefulWidget {
  final String title;
  final String content;
  final bool? isCancel;
  final bool? isLogout; // Added new parameter
  const ShowAleartComman({
    super.key,
    required this.title,
    required this.content,
    this.isCancel,
    this.isLogout = false, // Default to false
  });

  @override
  State<ShowAleartComman> createState() => _ShowAleartCommanState();
}

class _ShowAleartCommanState extends State<ShowAleartComman> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      // shape: RoundedRectangleBorder(borderRadius: Sizer.radius(Sizer.s20)),
      contentPadding: EdgeInsets.zero,
      content: Builder(
        builder: (context) {
          var width = Get.size.width;
          return Container(
            padding: Sizer.paddingSymmetric(
              horizontal: Sizer.s10,
              vertical: Sizer.s10,
            ),
            decoration: BoxDecoration(borderRadius: Sizer.radius(Sizer.s10)),
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AllFunction.commonPopinsText(
                    widget.title,
                    textAlign: TextAlign.center,
                    fontWeight: PoppinsWeight.extraBold800,
                    color: AppColor.primaryColor,
                    fontSize: Sizer.font(Sizer.s20),
                  ),
                ),
                Gap(Sizer.s5),
                Divider(
                  height: Sizer.s10,
                  color: AppColor.primaryColor,
                  thickness: 2,
                ),
                Gap(Sizer.s5),
                AllFunction.commonPopinsText(
                  widget.content,
                  textAlign: TextAlign.left,
                  fontWeight: PoppinsWeight.medium500,
                  color: AppColor.primaryColor,
                  fontSize: Sizer.font(
                    widget.isLogout == true ? Sizer.s16 : Sizer.s18,
                  ),
                ),
                Gap(Sizer.s20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (widget.isLogout ?? false)
                      ? [
                          Expanded(
                            child: CommonButton(
                              isBoarder: true,
                              verticalPadding: Sizer.s5,
                              text: StringConstants.no,
                              onTap: () {
                                Get.back();
                              },
                              borderRadius: Sizer.s10,
                              backgroundColor: (widget.isLogout ?? false)
                                  ? AppColor.errorColor
                                  : AppColor.orangeLightColor,
                              textColor: (widget.isLogout ?? false)
                                  ? AppColor.whiteColor
                                  : AppColor.orangeLightColor,
                              borderColor: AppColor.orangeLightColor,
                            ),
                          ),
                          Gap(Sizer.s20),
                          Expanded(
                            child: CommonButton(
                              verticalPadding: Sizer.s5,
                              isGradient: true,
                              borderRadius: Sizer.s10,
                              text: StringConstants.yes,
                              onTap: () {
                                Get.back(result: StringConstants.yes);
                              },
                              backgroundColor: AppColor.orangeLightColor,
                              borderColor: AppColor.orangeLightColor,
                              textColor: AppColor.whiteColor,
                            ),
                          ),
                        ]
                      : [
                          if (!(widget.isCancel ?? true))
                            Expanded(
                              child: CommonButton(
                                text: StringConstants.cancel,
                                onTap: () {
                                  Get.back();
                                },
                                backgroundColor: AppColor.orangeLightColor,
                                textColor: AppColor.errorColor,
                                borderColor: AppColor.errorColor,
                              ),
                            ),
                          if (!(widget.isCancel ?? true)) Gap(Sizer.s20),
                          Expanded(
                            child: CommonButton(
                              text: StringConstants.ok,
                              onTap: () {
                                Get.back(result: true);
                              },
                              backgroundColor: AppColor.orangeLightColor,
                              borderColor: AppColor.primaryColor,
                              textColor: AppColor.whiteColor,
                            ),
                          ),
                        ],
                ),
              ],
            ).paddingAll(Sizer.s10),
          );
        },
      ),
    );
  }
}
