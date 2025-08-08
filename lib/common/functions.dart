import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sumul_transport/presentation/dashboard/model/dashboard_model.dart';
import 'package:sumul_transport/resources/app_color.dart';
import 'package:sumul_transport/resources/app_string.dart';
import 'package:sumul_transport/routes/app_routes.dart';
import 'package:sumul_transport/utils/app_enums.dart';
import 'package:sumul_transport/utils/app_extentions.dart';
import 'package:sumul_transport/resources/app_font_family.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';
import 'package:sumul_transport/utils/time_utils.dart';
import 'package:sumul_transport/widgets/show_comman_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sumul_transport/di/di_helper_services.dart';

class AllFunction {
  static String updateShiftMessage(RxList<OrderTimeWindow> orderWindows) {
    final selectedType = AppServices.settings.selectedMainCategory;
    AllFunction.safeLog("selected Type:$selectedType");
    final typeWindows = orderWindows
        .where((w) => w.ordertype == selectedType)
        .toList();
    final now = TimeUtils.now();

    if (typeWindows.isEmpty) return '';

    final morningWindows = typeWindows.where((w) => w.shift == 'M').toList();
    final eveningWindows = typeWindows.where((w) => w.shift == 'E').toList();
    final dPWindows = typeWindows.where((w) => w.shift == 'O').toList();
    //
    for (var w in typeWindows) {
      final start = w.parsedStartTimeWithDate(now);
      final end = w.parsedEndTimeWithDate(now);

      AllFunction.safeLog(
        "Checking shift: ${w.shift}, Start: $start, End: $end, Now: $now",
      );

      if (now.isAfter(start) && now.isBefore(end)) {
        AppServices.settings.shift = w.shift ?? "";
        AllFunction.safeLog("✅ Shift matched and set to: ${w.shift}");
        break;
      }
    }
    AllFunction.safeLog("Shift =====> ${AppServices.settings.shift}");
    bool isInActiveWindow = typeWindows.any(
      (w) =>
          now.isAfter(w.parsedStartTimeWithDate(TimeUtils.now())) &&
          now.isBefore(w.parsedEndTimeWithDate(TimeUtils.now())),
    );

    bool isBeforeAllShifts = typeWindows.every(
      (w) => now.isBefore(w.parsedStartTimeWithDate(TimeUtils.now())),
    );

    if (isInActiveWindow) return '';

    if (isBeforeAllShifts) {
      final nextStart = typeWindows
          .map((w) => w.parsedStartTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final nextEnd = typeWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final formatted = DateFormat.jm().format(nextStart);
      final formattedEnd = DateFormat.jm().format(nextEnd);
      return "🕒 ${StringConstants.ordertime} $formatted $formattedEnd";
    }

    bool showMorningEnded = false;
    bool showEveningEnded = false;
    bool showdPEnded = false;

    if (morningWindows.isNotEmpty) {
      final latestEnd = morningWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isAfter(b) ? a : b);
      showMorningEnded = now.isAfter(latestEnd);
    }

    if (dPWindows.isNotEmpty) {
      final latestEnd = dPWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isAfter(b) ? a : b);
      showdPEnded = now.isAfter(latestEnd);
    }

    if (eveningWindows.isNotEmpty) {
      final latestEnd = eveningWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isAfter(b) ? a : b);
      showEveningEnded = now.isAfter(latestEnd);
    }

    if (showMorningEnded && showEveningEnded) {
      final m = formatTimeRange(morningWindows);
      final e = formatTimeRange(eveningWindows);
      return "🕒 ${StringConstants.allordertime} $m & $e ${StringConstants.hasended}";
    } else if (showEveningEnded) {
      final e = formatTimeRange(eveningWindows);
      return "🕒 ${StringConstants.ordertime} $e ${StringConstants.hasended}";
    } else if (showMorningEnded) {
      final m = formatTimeRange(morningWindows);
      return "🕒 ${StringConstants.ordertime} $m ${StringConstants.hasended}";
    } else if (showdPEnded) {
      final m = formatTimeRange(dPWindows);
      return "🕒 ${StringConstants.ordertime} $m ${StringConstants.hasended}";
    }

    return '';
  }

  static String updateDistributorShiftMessage(
    RxList<OrderTimeWindow> orderWindows,
  ) {
    const selectedType = "Distributor"; // Hardcoded for Distributor
    AllFunction.safeLog("selected Type: $selectedType");

    final typeWindows = orderWindows
        .where((w) => w.ordertype == selectedType)
        .toList();
    final now = TimeUtils.now();

    if (typeWindows.isEmpty) return '';

    final morningWindows = typeWindows.where((w) => w.shift == 'M').toList();
    final eveningWindows = typeWindows.where((w) => w.shift == 'E').toList();

    for (var w in typeWindows) {
      final start = w.parsedStartTimeWithDate(now);
      final end = w.parsedEndTimeWithDate(now);

      AllFunction.safeLog(
        "Checking shift: ${w.shift}, Start: $start, End: $end, Now: $now",
      );

      if (now.isAfter(start) && now.isBefore(end)) {
        AppServices.settings.shift = w.shift ?? "";
        AllFunction.safeLog("✅ Shift matched and set to: ${w.shift}");
        break;
      }
    }

    AllFunction.safeLog("Shift =====> ${AppServices.settings.shift}");

    final isInActiveWindow = typeWindows.any(
      (w) =>
          now.isAfter(w.parsedStartTimeWithDate(TimeUtils.now())) &&
          now.isBefore(w.parsedEndTimeWithDate(TimeUtils.now())),
    );

    final isBeforeAllShifts = typeWindows.every(
      (w) => now.isBefore(w.parsedStartTimeWithDate(TimeUtils.now())),
    );

    if (isInActiveWindow) return '';

    if (isBeforeAllShifts) {
      final nextStart = typeWindows
          .map((w) => w.parsedStartTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final nextEnd = typeWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final formatted = DateFormat.jm().format(nextStart);
      final formattedEnd = DateFormat.jm().format(nextEnd);
      return "🕒 ${StringConstants.ordertime} $formatted $formattedEnd";
    }

    bool showMorningEnded = false;
    bool showEveningEnded = false;
    if (morningWindows.isNotEmpty) {
      final latestEnd = morningWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isAfter(b) ? a : b);
      showMorningEnded = now.isAfter(latestEnd);
    }

    if (eveningWindows.isNotEmpty) {
      final latestEnd = eveningWindows
          .map((w) => w.parsedEndTimeWithDate(TimeUtils.now()))
          .reduce((a, b) => a.isAfter(b) ? a : b);
      showEveningEnded = now.isAfter(latestEnd);
    }

    if (showMorningEnded && showEveningEnded) {
      final m = formatTimeRange(morningWindows);
      final e = formatTimeRange(eveningWindows);
      return "🕒 ${StringConstants.allordertime} $m & $e ${StringConstants.hasended}";
    } else if (showEveningEnded) {
      final e = formatTimeRange(eveningWindows);
      return "🕒 ${StringConstants.ordertime} $e ${StringConstants.hasended}";
    } else if (showMorningEnded) {
      final m = formatTimeRange(morningWindows);
      return "🕒 ${StringConstants.ordertime} $m ${StringConstants.hasended}";
    }
    return '';
  }

  static String formatTimeRange(List<OrderTimeWindow> windows) {
    final times = windows.map((w) => "${w.start} to ${w.end}").toSet().toList();

    return times.join(" & ");
  }

  static bool isStringNullOrEmptyOrBlank(String value) {
    return value.isEmptyOrNull || value.isEmpty || value.trim().isEmpty;
  }

  static Future<bool> checkConnectivity() async {
    // final result = await Connectivity()
    // return (result.every((element) => element != ConnectivityResult.none));
    return true;
  }

  static String calculateDateDifference(String inputDate) {
    // Manually fix month capitalization without regex
    List<String> parts = inputDate.split('-');
    if (parts.length >= 3) {
      parts[1] = parts[1][0] + parts[1].substring(1).toLowerCase(); // JUN → Jun
      inputDate = parts.join('-');
    }

    try {
      final formatter = DateFormat('dd-MMM-yyyy hh:mm:ss a');
      final parsedDate = formatter.parse(inputDate);
      final now = DateTime.now();
      final diff = now.difference(parsedDate);

      final days = diff.inDays;
      final hours = diff.inHours % 24;
      final minutes = diff.inMinutes % 60;

      return days > 0
          ? "$days days $hours hours $minutes minutes"
          : hours > 0
          ? "$hours hours $minutes minutes"
          : "$minutes minutes";
    } catch (e) {
      return "";
    }
  }

  static Text commonPopinsText(
    String title, {
    double fontSize = Sizer.s14,
    PoppinsWeight fontWeight = PoppinsWeight.regular400,
    Color color = Colors.black,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    // final poppinsWeight = getPoppinsWeightFromString(fontWeight);

    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: true,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: FontFamilyConstants.poppins,
        fontWeight: fontWeight.weight,
        color: color,
        fontStyle: fontStyle,
        decoration: TextDecoration.none,
      ),
    );
  }

  static FontWeight getFontWeight(PoppinsWeight weight) {
    switch (weight) {
      case PoppinsWeight.thin100:
        return FontWeight.w100;
      case PoppinsWeight.extraLight200:
        return FontWeight.w200;
      case PoppinsWeight.light300:
        return FontWeight.w300;
      case PoppinsWeight.regular400:
        return FontWeight.w400;
      case PoppinsWeight.medium500:
        return FontWeight.w500;
      case PoppinsWeight.semiBold600:
        return FontWeight.w600;
      case PoppinsWeight.bold700:
        return FontWeight.w700;
      case PoppinsWeight.extraBold800:
        return FontWeight.w800;
      case PoppinsWeight.black900:
        return FontWeight.w900;
    }
  }

  static void changeLanguage(String languageCode) {
    final locale = Locale(languageCode);
    AppServices.settings.languageCode = languageCode;
    Get.updateLocale(locale);
  }

  static final List<Color> menuColors = [
    AppColor.primaryColor,
    AppColor.secondaryColor,
    AppColor.orangeLightColor,
    Colors.teal,
    Colors.deepOrange,
    Colors.indigo,
  ];
  BoxShadow commonBoxShadow({Color? color}) {
    return BoxShadow(
      color: color ?? AppColor.blackColor.withValues(alpha: 0.2),
      blurRadius: 4,
      offset: Offset(2, 4),
      spreadRadius: 0.4,
    );
  }

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  static String commonTranslateMethodForProduct(dynamic product) {
    final locale =
        Get.locale?.languageCode ??
        StringConstants.langEnglishCode; // fallback to English

    switch (locale) {
      case StringConstants.langGujaratiCode:
        return product.prodpackdescGuj ?? product.prodpackdesc ?? '';
      case StringConstants.langHindiCode:
        return product.prodpackdescHin ?? product.prodpackdesc ?? '';
      case StringConstants.langEnglishCode:
      default:
        return product.prodpackdesc ?? '';
    }
  }

  /// Requests a single permission and returns true if granted.
  static Future<bool> requestPermission(Permission permission) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await permission.request();
      return status.isGranted;
    }
    return false;
  }

  static void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Cannot open link.");
    }
  }

  Widget headeritemChip({
    int flex = 1,
    String title = "",
    Color color = AppColor.blackColor,
  }) {
    return Expanded(
      flex: flex,
      child: AllFunction.commonPopinsText(
        title,
        color: color,
        fontWeight: PoppinsWeight.bold700,
      ),
    );
  }

  static logOutAll({bool? isAsk = true}) async {
    try {
      await Get.dialog(
        ShowAleartComman(
          title: StringConstants.alert.capitalized,
          content: "${StringConstants.logOutText} ?",
          isLogout: true,
        ),
      ).then((value) async {
        if (value != null) {
          if (value == StringConstants.yes) {
            await logout();
          } else {
            Get.back();
          }
        }
      });
    } catch (e) {
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
    }
  }

  static Future<void> logout() async {
    AppServices.settings.selectedAgent = "";
    AppServices.settings.selectedAgentName = "";
    AppServices.settings.selectedMainCategory = "";
    AppServices.settings.unreadCount = 0;
    AppServices.settings.userId = "";
    AppServices.settings.isUserLoggedIn = false;
    AppServices.settings.clear();
    Get.offNamedUntil(Routes.authscreen, (route) => false);
  }

  static String commonDateformat(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String commonDateformatWithTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy-Hms').format(date);
  }

  //Check Availability of menu
  static bool? checkVisibility(String comapreValue) {
    if (MainCategoryExtension.fromString(comapreValue)?.displayName ==
        AppServices.settings.selectedMainCategory) {
      return true;
    } else {
      return false;
    }
  }

  static divider() {
    return Container(
      decoration: BoxDecoration(color: AppColor.greyColor),
      height: Sizer.height(Sizer.s16),
      width: 2,
    );
  }

  static void safeLog(String message) {
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }

  static String getMainCategoryShortCode() {
    return AppServices.settings.selectedMainCategory.toLowerCase() ==
            MainCategoryEnum.milk.displayName.toLowerCase()
        ? MainCategoryEnum.milk.shortCode
        : AppServices.settings.selectedMainCategory.toLowerCase() ==
              MainCategoryEnum.dairyProduct.displayName.toLowerCase()
        ? MainCategoryEnum.dairyProduct.shortCode
        : MainCategoryEnum.bakery.shortCode;
  }

  static String getMainCategoryName() {
    if (AppServices.settings.isDistributor) {
      return MainCategoryEnum.milk.displayName;
    } else {
      return AppServices.settings.selectedMainCategory.toLowerCase() ==
              MainCategoryEnum.milk.displayName.toLowerCase()
          ? MainCategoryEnum.milk.displayName
          : AppServices.settings.selectedMainCategory.toLowerCase() ==
                MainCategoryEnum.dairyProduct.displayName.toLowerCase()
          ? MainCategoryEnum.dairyProduct.displayName
          : MainCategoryEnum.bakery.displayName;
    }
  }

  static List<String> getLastTwoMonths() {
    final now = DateTime.now();
    final List<String> months = [];

    for (int i = 0; i < 2; i++) {
      final date = DateTime(now.year, now.month - i);
      final formatted = DateFormat('MMM-yyyy').format(date); // e.g., Aug-2025
      months.add(formatted);
    }

    return months;
  }
}
