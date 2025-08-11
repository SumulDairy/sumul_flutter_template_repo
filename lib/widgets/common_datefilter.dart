import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonDateFilter extends StatelessWidget {
  final Rxn<DateTime> selectedDate;
  final VoidCallback onPickDate;
  final String? dateText;
  final bool? isIconVisible;

  const CommonDateFilter({
    super.key,
    required this.selectedDate,
    required this.onPickDate,
    this.dateText,
    this.isIconVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AllFunction.commonPopinsText(
          dateText ?? StringConstants.changeDate,
          fontSize: Sizer.font(Sizer.s14),
          fontWeight: PoppinsWeight.semiBold600,
          color: AppColor.primaryColor,
        ),
        if ((isIconVisible ?? false))
          IconButton(
            icon: Icon(
              Icons.filter_list_alt,
              color: AppColor.blueColor,
              size: Sizer.s32,
            ),
            onPressed: onPickDate,
          ),
      ],
    ).onInkTap(onPickDate);
  }
}

class CommonDatePicker {
  /// Opens a date picker and updates the given Rx value
  static Future<void> pick({
    required BuildContext context,
    required Rxn<DateTime> target,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    VoidCallback? onDatePicked, // ✅ New callback
  }) async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? target.value ?? now,
      firstDate: firstDate ?? DateTime(2024),
      lastDate: lastDate ?? now,
    );

    if (picked != null) {
      target.value = picked;
      if (onDatePicked != null) {
        onDatePicked(); // ✅ trigger callback
      }
    }
  }
}
