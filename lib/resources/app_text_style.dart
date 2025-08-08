import 'package:flutter/material.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

class AppTextStyles {
  static const _font = 'Poppins';

  static TextTheme getTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final primary = isDark ? Colors.white : Colors.black;
    final secondary = isDark ? Colors.grey[300]! : Colors.grey[700]!;

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: _font,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      displayMedium: TextStyle(
        fontFamily: _font,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      displaySmall: TextStyle(
        fontFamily: _font,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      titleMedium: TextStyle(
        fontFamily: _font,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      bodyLarge: TextStyle(
        fontFamily: _font,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: primary,
      ),
      bodyMedium: TextStyle(fontFamily: _font, fontSize: 14, color: secondary),
      labelLarge: TextStyle(
        fontFamily: _font,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.black : Colors.white,
      ),
    );
  }

  static TextStyle _baseStyle({
    required double size,
    required PoppinsWeight weight,
    Color color = AppColor.blackColor,
    double letterSpacing = 0,
    double? height,
  }) {
    return TextStyle(
      fontSize: Sizer.font(size),
      fontWeight: AllFunction.getFontWeight(weight),
      fontFamily: FontFamilyConstants.poppins,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Thin
  static TextStyle thin = _baseStyle(size: 24, weight: PoppinsWeight.thin100);
  static TextStyle thinSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.thin100,
  );

  // ExtraLight
  static TextStyle extraLight = _baseStyle(
    size: 24,
    weight: PoppinsWeight.extraLight200,
  );
  static TextStyle extraLightSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.extraLight200,
  );

  // Light
  static TextStyle light = _baseStyle(size: 24, weight: PoppinsWeight.light300);
  static TextStyle lightSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.light300,
  );

  // Regular
  static TextStyle regular = _baseStyle(
    size: 24,
    weight: PoppinsWeight.regular400,
  );
  static TextStyle regularMedium = _baseStyle(
    size: 20,
    weight: PoppinsWeight.regular400,
  );
  static TextStyle regularSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.regular400,
  );

  // Medium
  static TextStyle medium = _baseStyle(
    size: 24,
    weight: PoppinsWeight.medium500,
  );
  static TextStyle mediumSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.medium500,
  );

  // SemiBold
  static TextStyle semiBold = _baseStyle(
    size: 24,
    weight: PoppinsWeight.semiBold600,
  );
  static TextStyle semiBoldMedium = _baseStyle(
    size: 20,
    weight: PoppinsWeight.semiBold600,
  );
  static TextStyle semiBoldSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.semiBold600,
  );

  // Bold
  static TextStyle bold = _baseStyle(size: 24, weight: PoppinsWeight.bold700);
  static TextStyle boldSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.bold700,
  );

  // ExtraBold
  static TextStyle extraBold = _baseStyle(
    size: 24,
    weight: PoppinsWeight.extraBold800,
  );
  static TextStyle extraBoldSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.extraBold800,
  );

  // Black
  static TextStyle black = _baseStyle(size: 24, weight: PoppinsWeight.black900);
  static TextStyle blackSmall = _baseStyle(
    size: 16,
    weight: PoppinsWeight.black900,
  );

  // Caption and Overline
  static TextStyle caption = _baseStyle(
    size: 12,
    weight: PoppinsWeight.regular400,
    letterSpacing: 0.4,
  );

  static TextStyle overline = _baseStyle(
    size: 10,
    weight: PoppinsWeight.regular400,
    letterSpacing: 1.5,
    height: 1.5,
  );

  // Accent and Disabled
  static TextStyle semiBoldAccent = _baseStyle(
    size: 24,
    weight: PoppinsWeight.semiBold600,
    color: AppColor.greenColor,
  );

  static TextStyle regularDisabled = _baseStyle(
    size: 16,
    weight: PoppinsWeight.regular400,
    color: AppColor.greyColor,
  );
}
