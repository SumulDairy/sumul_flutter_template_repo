import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';

class UnreadNotificationAlert extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  const UnreadNotificationAlert({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (AllFunction.isStringNullOrEmptyOrBlank(message)) {
      return SizedBox.shrink();
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: Sizer.paddingSymmetric(
          horizontal: Sizer.s12,
          vertical: Sizer.s10,
        ),
        decoration: BoxDecoration(
          color: AppColor.orangeLightColor.withValues(alpha: 0.5),
          borderRadius: Sizer.radius(Sizer.s10),
          // border: Border.all(color: Colors.orange),
        ),
        child: Row(
          children: [
            Icon(
              Icons.notifications_active_outlined,
              color: AppColor.primaryColor,
            ),
            Gap(Sizer.s16),
            Expanded(
              child: AllFunction.commonPopinsText(
                message,
                color: AppColor.mediumBlackColor,
                fontWeight: PoppinsWeight.bold700,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Sizer.s20,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    ).paddingAll(Sizer.s10);
  }
}
