import 'package:flutter/material.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_extentions.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CommonText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color,
    this.fontFamily,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: commonTextStyle(
        fontSize: Sizer.font(fontSize),
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

TextStyle commonTextStyle({
  double? fontSize,
  Color? color,
  String? fontFamily,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize ?? Sizer.s16,
    color: color ?? AppColor.mediumBlackColor,
    fontFamily: fontFamily ?? FontFamilyConstants.poppins,
    fontWeight: fontWeight ?? PoppinsWeight.regular400.weight,
  );
}
