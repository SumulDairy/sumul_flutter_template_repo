import 'package:flutter/material.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/resources/app_text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: FontFamilyConstants.poppins,
    scaffoldBackgroundColor: AppColor.whiteColor,
    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.whiteColor,
      error: AppColor.errorColor,
    ),
    textTheme: AppTextStyles.getTextTheme(Brightness.light),
    elevatedButtonTheme: _elevatedButtonTheme(AppColor.whiteColor),
    inputDecorationTheme: _inputDecorationTheme(
      AppColor.whiteColor,
      AppColor.containerLightGreyColor,
    ),
    // cardTheme: _cardTheme(AppColor.lightHighlihgtBlueColor),
  );

  static ThemeData darkTheme =
      ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: FontFamilyConstants.poppins,
        colorScheme: ColorScheme.dark(
          primary: AppColor.primaryColor,
          secondary: AppColor.whiteColor,
          error: AppColor.errorColor,
        ),
        textTheme: AppTextStyles.getTextTheme(Brightness.dark),
        elevatedButtonTheme: _elevatedButtonTheme(AppColor.blackColor),
        inputDecorationTheme: _inputDecorationTheme(
          AppColor.mediumBlackColor,
          AppColor.containerLightGreyColor,
        ),
        // cardTheme: _cardTheme(Colors.grey[200]!), // cards still look raised
      ).copyWith(
        scaffoldBackgroundColor:
            AppColor.whiteColor, // override only background
      );

  // Reusable styles
  static ElevatedButtonThemeData _elevatedButtonTheme(Color foregroundColor) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: foregroundColor,
        padding: Sizer.paddingSymmetric(
          horizontal: Sizer.s24,
          vertical: Sizer.s14,
        ),
        shape: RoundedRectangleBorder(borderRadius: Sizer.radius(Sizer.s10)),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(
    Color fillColor,
    Color hintColor,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: TextStyle(color: hintColor),
      contentPadding: Sizer.paddingSymmetric(
        horizontal: Sizer.s16,
        vertical: Sizer.s14,
      ),
      border: OutlineInputBorder(
        borderRadius: Sizer.radius(Sizer.s10),
        borderSide: const BorderSide(color: AppColor.lightGreyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Sizer.radius(Sizer.s10),
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
    );
  }

  // static CardTheme _cardTheme(Color cardColor) {
  //   return CardTheme(
  //     color: cardColor,
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //   );
  // }
}
