import 'package:flutter/material.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_extentions.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

class CommanPopinsText extends StatelessWidget {
  final String title;
  final double? fontsize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const CommanPopinsText({
    super.key,
    required this.title,
    this.fontsize,
    this.color,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: fontsize ?? Sizer.s16,
        fontFamily: FontFamilyConstants.poppins,
        fontWeight: fontWeight ?? PoppinsWeight.regular400.weight,
        color: color ?? AppColor.blackColor,
      ),
    );
  }
}
