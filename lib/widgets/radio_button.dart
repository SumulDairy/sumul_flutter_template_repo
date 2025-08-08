import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_extentions.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/resources/app_image_assets.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/widgets/common_text.dart';

class YesNoRadioButton extends StatelessWidget {
  final String? groupValue; // "yes" or "no"
  final ValueChanged<String?> onChanged;
  final bool isHorizontal;

  const YesNoRadioButton({
    super.key,
    required this.groupValue,
    required this.onChanged,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final options = ["yes", "no"];

    List<Widget> radioButtons = options.map((value) {
      final isSelected = groupValue == value;
      return GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected
                  ? ImageConstants.imgSelectdRadio
                  : ImageConstants.imgUnselectRadio,
              height: Sizer.height(Sizer.s24),
              width: Sizer.width(Sizer.s24),
              fit: BoxFit.contain,
            ),

            Gap(Sizer.s8),
            CommonText(
              text: value == "yes" ? StringConstants.yes : StringConstants.no,
              fontSize: Sizer.s16,
              fontFamily: FontFamilyConstants.poppins,
              fontWeight: PoppinsWeight.regular400.weight,
              color: AppColor.blackColor,
            ),

            if (isHorizontal) const SizedBox(width: 20),
          ],
        ),
      );
    }).toList();

    return isHorizontal
        ? Wrap(spacing: Sizer.s8, runSpacing: Sizer.s8, children: radioButtons)
        : Column(children: radioButtons);
  }
}
