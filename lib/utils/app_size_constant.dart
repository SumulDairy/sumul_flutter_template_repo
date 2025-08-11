import 'dart:ui';
import 'package:flutter/material.dart';

class Sizer {
  static const double baseHeight = 812.0; // iPhone X
  static const double baseWidth = 375.0;

  /// Font/Size tokens from 1 to 100 (step of 1–10, to keep it manageable)
  static const double s1 = 1;
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s5 = 5;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s50 = 50;
  static const double s56 = 56;
  static const double s60 = 60;
  static const double s64 = 64;
  static const double s72 = 72;
  static const double s80 = 80;
  static const double s90 = 90;
  static const double s100 = 100;

  static final Size _screenSize =
      PlatformDispatcher.instance.views.first.physicalSize /
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  static double get _screenWidth => _screenSize.width;
  static double get _screenHeight => _screenSize.height;

  /// ✅ Device type detection
  static bool get isMobile => _screenWidth < 600;
  static bool get isTablet => _screenWidth >= 600 && _screenWidth < 1280;
  static bool get isDesktop => _screenWidth >= 1280;

  /// ✅ Orientation detection
  static bool get isPortrait => _screenHeight > _screenWidth;

  /// ✅ Scaled width based on base width (375)
  static double width(double value) => (value / baseWidth) * _screenWidth;

  /// ✅ Scaled height based on base height (812)
  static double height(double value) => (value / baseHeight) * _screenHeight;

  /// ✅ Scaled font size depending on device type
  static double font(double value) {
    if (isMobile) return value;
    if (isTablet) return value * 1.15;
    return value * 1.25;
  }

  /// ✅ Padding helpers using width scale
  static EdgeInsets paddingAll(double value) => EdgeInsets.all(width(value));

  static EdgeInsets paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) => EdgeInsets.symmetric(
    horizontal: width(horizontal),
    vertical: height(vertical),
  );

  static EdgeInsets paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: width(left),
    top: height(top),
    right: width(right),
    bottom: height(bottom),
  );

  /// ✅ Margin helpers (uses same logic as padding)
  static EdgeInsets marginAll(double value) => paddingAll(value);

  static EdgeInsets marginSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) => paddingSymmetric(horizontal: horizontal, vertical: vertical);

  static EdgeInsets marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => paddingOnly(left: left, top: top, right: right, bottom: bottom);

  /// ✅ Border Radius using width scale
  static BorderRadius radius(double value) =>
      BorderRadius.circular(width(value));

  static BorderRadius radiusOnly({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(width(topLeft)),
      topRight: Radius.circular(width(topRight)),
      bottomLeft: Radius.circular(width(bottomLeft)),
      bottomRight: Radius.circular(width(bottomRight)),
    );
  }

  /// ✅ Box size (like Container size)
  static Size boxSize(double w, double h) => Size(width(w), height(h));
}
