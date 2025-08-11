// App Colors

import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = Color(0xFF3354A5);
  static const Color lightBlueColor = Color(0xFFE6EDFF);
  static const Color errorColor = Color(0xFFB00020);
  static const Color darkRedColor = Color(0xFFFA472A);
  static const Color lightRedColor = Color(0xFFFFDBD4);
  static const Color lightHighlihgtBlueColor = Color(0xFFBFCCED);
  static const Color secondaryColor = Color(0xFFDB9A3F);
  static const Color darkOrangeColor = Color(0xFFD59C00);
  static const Color orangeLightColor = Color(0xFFE3AF66);
  static const Color orangeExtraLightColor = Color(0xFFFFECD0);
  static const Color darkBlackColor = Color(0xFF030303);
  static const Color mediumBlackColor = Color(0xFF404040);
  static const Color lightBlackColor = Color(0x4040404D);
  static const Color lightGreyColor = Color(0xFFE2E2E2);
  static const Color darkGreenColor = Color(0xFF22BC7E);
  static const Color lightGreenColor = Color(0xFFCDF4E4);
  static const Color containerLightGreyColor = Color(0xFFF3F3F3);

  static const Color dpProductColor = Color(0xFFA4E1FF);

  static const greyColor = Colors.grey;
  static const redColor = Colors.red;
  static const greenColor = Colors.green;
  static const transparentColor = Colors.transparent;
  static const blackColor = Color(0xff000000);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blueColor = Color(0xFF1269B0);
  static const employeeNoBorderColorShadow = Color(0xFFA3B4DD);
  static const disableIconClickColor = Color(0xFF95A7D2);
  static const disableTextColor = Color(0xFF969696);
  // Hexadecimal Color
  static Color hexGreyColor = fromHex('#121212');

  static const Map<int, Color> orange = <int, Color>{
    50: Color(0xFFFCF2E7),
    100: Color(0xFFF8DEC3),
    200: Color(0xFFF3C89C),
    300: Color(0xFFEEB274),
    400: Color(0xFFEAA256),
    500: Color(0xFFE69138),
    600: Color(0xFFE38932),
    700: Color(0xFFDF7E2B),
    800: Color(0xFFDB7424),
    900: Color(0xFFD56217),
  };

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static LinearGradient getGradient(Color colorStart, Color colorEnd) {
    return LinearGradient(
      colors: [colorStart, colorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
