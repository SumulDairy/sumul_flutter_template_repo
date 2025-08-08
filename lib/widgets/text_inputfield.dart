import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/widgets/common_text.dart';

class CommonInputFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enabled;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final double? fontSizeHint;
  final double? borderRadius;
  final Color? colorHint;
  final String? fontFamilyHint;
  final FontWeight? fontWeightHint;
  final Color? textColor;
  final String? textFontFamily;
  final FontWeight? textFontWeight;
  final double? textfontSize;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isReadOnly;
  final TextAlign? textAlign;
  final Function()? onEditingComplete;
  final Function()? onFieldSubmitted;
  final void Function()? obscureClick;
  final dynamic pagecontrollers;
  final BorderSide? borderSide;

  const CommonInputFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.borderRadius,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.colorHint,
    this.fontSizeHint,
    this.fontFamilyHint,
    this.fontWeightHint,
    this.textInputAction,
    this.onChanged,
    this.inputFormatters,
    this.textColor,
    this.textFontFamily,
    this.textFontWeight,
    this.textfontSize,
    this.isReadOnly,
    this.textAlign,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.obscureClick,
    this.pagecontrollers,
    this.borderSide,
  });

  @override
  State<CommonInputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<CommonInputFormField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      obscureText: isObscure,
      enabled: widget.enabled,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign ?? TextAlign.left,
      style: commonTextStyle(
        fontSize: widget.textfontSize,
        color: widget.textColor,
        fontFamily: widget.textFontFamily,
        fontWeight: widget.textFontWeight,
      ),

      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      readOnly: widget.isReadOnly ?? false,
      decoration: InputDecoration(
        fillColor: (widget.isReadOnly ?? false)
            ? AppColor.containerLightGreyColor
            : AppColor.whiteColor,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        errorStyle: commonTextStyle(
          fontSize: ((widget.textfontSize ?? 0) / 1.2),
          color: AppColor.darkRedColor,
          fontFamily: widget.textFontFamily,
          fontWeight: widget.textFontWeight,
        ),
        hintStyle: commonTextStyle(
          fontSize: widget.fontSizeHint,
          color: widget.colorHint,
          fontFamily: widget.fontFamilyHint,
          fontWeight: widget.fontWeightHint,
        ),
        suffixIcon: widget.obscureClick != null
            ? IconButton(
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  // setState(() {
                  isObscure = !isObscure;
                  // });
                },
              )
            : null,
        contentPadding: Sizer.paddingAll(Sizer.s10),

        // border: OutlineInputBorder(
        //   borderRadius: Sizer.radius(widget.borderRadius ?? Sizer.ten),
        // ),
        // 🎯 Add these for consistent border styling
        border: OutlineInputBorder(
          borderRadius: Sizer.radius(widget.borderRadius ?? Sizer.s10),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: Sizer.radius(widget.borderRadius ?? Sizer.s10),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: Sizer.radius(widget.borderRadius ?? Sizer.s10),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: Sizer.radius(widget.borderRadius ?? Sizer.s10),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: Sizer.radius(widget.borderRadius ?? Sizer.s10),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
      ),
    );
  }
}
