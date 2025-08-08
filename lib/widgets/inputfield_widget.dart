import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_extentions.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/widgets/text_inputfield.dart';

class InputRow extends StatelessWidget {
  const InputRow({
    super.key,
    this.title,
    required this.inputController,
    this.backgroundColor,
    this.textColor,
    this.fontsize,
    this.fontWeight,
    this.onEditingComplete,
    this.onTextChange,
    this.isReadOnly,
    this.focusNode,
  });

  final String? title;
  final TextEditingController inputController;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontsize;
  final PoppinsWeight? fontWeight;
  final Function()? onEditingComplete;
  final void Function(String)? onTextChange;
  final bool? isReadOnly;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Sizer.paddingOnly(
        left: Sizer.s10,
        right: Sizer.s5,
        bottom: Sizer.s5,
        top: Sizer.s5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: Sizer.radius(Sizer.s8),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? Colors.grey).withValues(alpha: .3),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AllFunction.commonPopinsText(
              title ?? "",
              fontSize: fontsize ?? Sizer.font(Sizer.s14),
              fontWeight: fontWeight ?? PoppinsWeight.regular400,
              color: textColor ?? AppColor.blackColor,
            ),
          ),
          Gap(Sizer.width(Sizer.s10)),
          SizedBox(
            width: Sizer.width(Get.size.width * 0.17),
            child: Focus(
              focusNode: focusNode,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  onEditingComplete?.call();
                }
              },
              child: CommonInputFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: inputController,
                hintText: "",
                obscureText: false,
                borderRadius: Sizer.s8,
                textAlign: TextAlign.center,
                isReadOnly: isReadOnly,
                textFontWeight: fontWeight?.weight,
                keyboardType: TextInputType.number,
                onEditingComplete: onEditingComplete, // ✅ THIS LINE IS KEY
                onFieldSubmitted: () => onEditingComplete?.call(),
                borderSide: BorderSide(
                  color: AppColor.lightHighlihgtBlueColor.withValues(
                    alpha: 0.7,
                  ),
                ),
                onChanged: onTextChange,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return StringConstants.loginScreenPleaseEnterUsername;
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
