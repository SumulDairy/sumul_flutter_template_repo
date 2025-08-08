import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/widgets/validator.dart';

class CommonTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? validationMessage;
  final bool needValidation;
  final bool isEmailValidation;
  final double? topPadding;
  final double? bottomPadding;
  final TextEditingController? controller;
  final bool isPhoneValidation;
  final bool isPasswordValidation;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? maxLength;
  final double? borderRadius;
  final double? textSize;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool isTransparentColorBorder;
  final bool isBigTitle;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final bool obscureText;
  final bool boxShadow;
  final Color? titleColor;
  final bool readOnly;
  final Color? bgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? titleMargin;

  const CommonTextField({
    super.key,
    this.title,
    this.needValidation = false,
    this.isEmailValidation = false,
    this.hintText,
    this.validationMessage,
    this.topPadding,
    this.borderColor,
    this.bottomPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.boxShadow = true,
    this.readOnly = false,
    this.textSize,
    this.contentPadding,
    this.isPhoneValidation = false,
    this.textInputType,
    this.textAlign,
    this.borderRadius,
    this.inputFormatters,
    this.maxLine,
    this.maxLength,
    this.hintStyle,
    this.bgColor,
    this.isTransparentColorBorder = false,
    this.onTap,
    this.suffixIcon,
    this.isBigTitle = false,
    this.prefixIcon,
    this.validator,
    this.titleColor,
    this.isPasswordValidation = false,
    this.obscureText = false,
    this.onChange,
    this.margin,
    this.titleMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding ?? 0),
        if (title != null)
          Container(
            margin: titleMargin,
            child: Text(
              '$title',
              style: isBigTitle
                  ? TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    )
                  : TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
            ),
          ),
        if (title != null) const SizedBox(height: 11),
        Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            boxShadow: boxShadow == false
                ? kElevationToShadow[0]
                : [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Colors.black.withValues(alpha: .08),
                    ),
                  ],
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: maxLine ?? 1,
            textAlign: textAlign ?? TextAlign.start,
            onTap: onTap,
            maxLength: maxLength,
            controller: controller,
            onChanged: onChange,
            obscureText: obscureText,
            readOnly: readOnly,
            inputFormatters: inputFormatters ?? [],
            focusNode: focusNode,
            autofocus: autofocus,
            keyboardType: textInputType ?? TextInputType.text,
            style: TextStyle(
              fontSize: textSize ?? 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              fillColor: bgColor ?? AppColor.whiteColor,
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.only(top: 8, bottom: 16, right: 4, left: 20),
              isDense: true,
              filled: true,
              counterText: "",
              hintText: hintText ?? "",

              suffixIcon: suffixIcon,
              // suffixText: suffixText,
              // suffixStyle: suffixStyle,
              prefixIcon: prefixIcon,
              hintStyle:
                  hintStyle ??
                  TextStyle(
                    color:
                        borderColor ??
                        AppColor.blackColor.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isTransparentColorBorder
                      ? AppColor.transparentColor
                      : (borderColor ?? AppColor.greyColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isTransparentColorBorder
                      ? AppColor.transparentColor
                      : (borderColor ?? AppColor.greyColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isTransparentColorBorder
                      ? AppColor.transparentColor
                      : (borderColor ?? AppColor.greyColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isTransparentColorBorder
                      ? AppColor.transparentColor
                      : (borderColor ?? AppColor.greyColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
            ),
            validator: needValidation
                ? validator ??
                      (v) {
                        return TextFieldValidation.validation(
                          message: validationMessage.toString().toLowerCase(),
                          value: v,
                          isPasswordValidator: isPasswordValidation,
                          isPhone: isPhoneValidation,
                          isEmailValidator: isEmailValidation,
                        );
                      }
                : null,
          ),
        ),
        SizedBox(height: bottomPadding ?? 16),
      ],
    );
  }
}
