import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/model/dashboard_model.dart';
import 'package:sumul_hr/resources/app_color.dart';
import 'package:sumul_hr/resources/app_font_family.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/routes/app_routes.dart';
import 'package:sumul_hr/services/file_download_service/filedownload.dart';
import 'package:sumul_hr/utils/app_enums.dart';
import 'package:sumul_hr/utils/app_extentions.dart';
import 'package:sumul_hr/utils/app_size_constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AllFunction {
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

    // Fetchnotification().fetchAndScheduleNotifications();
  }

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

  static Future<void> downloadFile(String fileName, {String? fileUrl}) async {
    fileUrl =
        fileUrl ??
        "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

    try {
      await FileDownloadService.downloadAndOpenPdf(
        fileName: fileName,
        fileUrl: fileUrl,
      );
      // Get.snackbar("Download Complete", "$fileName opened.");
    } catch (e) {
      Get.snackbar("Download Failed", e.toString());
    }
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

  static Future<void> logout() async {
    AppServices.settings.selectedAgent = "";
    AppServices.settings.selectedAgentName = "";
    AppServices.settings.selectedMainCategory = "";
    AppServices.settings.unreadCount = 0;
    AppServices.settings.userId = "";
    AppServices.settings.isUserLoggedIn = false;
    AppServices.settings.clear();
    Get.offNamedUntil(Routes.AUTH_SCREEN, (route) => false);
  }

  // static void startNotificationPolling() {
  //   AllFunction.safeLog("🟢 Starting notification polling...");

  //   // 🧹 Avoid multiple timers
  //   pollingTimer?.cancel();

  //   // 🟢 Fetch immediately (user might open drawer before 10s)
  //   Fetchnotification().fetchAndScheduleNotifications();

  //   // 🔁 Start periodic polling
  //   pollingTimer = Timer.periodic(const Duration(seconds: 10), (_) {
  //     final now = DateTime.now();
  //     AllFunction.safeLog("⏰ Checking notifications at: $now");
  //     Fetchnotification().fetchAndScheduleNotifications();
  //   });
  // }

  /// Optional: Allow manual refresh
  // static Future<void> refreshNotificationNow() async {
  //   AllFunction.safeLog("🔄 Manual refresh triggered");
  //   await Fetchnotification().fetchAndScheduleNotifications();
  // }

  // Stop polling notifications
  // void stopNotificationPolling() {
  //   if (pollingTimer != null && pollingTimer!.isActive) {
  //     AllFunction.safeLog("🔴 Stopping notification polling...");
  //     pollingTimer?.cancel();
  //     pollingTimer = null;
  //   }
  // }

  static String commonDateformat(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String commonDateformatWithTime(DateTime date) {
    return DateFormat('dd-MMM-yyyy-Hms').format(date);
  }

  // //Get Menu

  static RxList<MenuGroup> getMenus() {
    return <MenuGroup>[
      MenuGroup(
        titleKey: StringConstants.menuHeaderOrderManagement,
        items: [
          MenuItem(
            titleKey: StringConstants.menuplaceOrder,
            iconPath: ImageConstants.imgPlaceOrder,
          ),
          MenuItem(
            titleKey: StringConstants.menucopyOrder,
            iconPath: ImageConstants.imgCopyOrder,
            isVisible: !(AppServices.settings.isDistributor),
          ),
          MenuItem(
            titleKey: StringConstants.menuextraorder,
            iconPath: ImageConstants.imgExtraOrder,
            isVisible: AppServices.settings.isExtra,
          ),
          MenuItem(
            titleKey: StringConstants.menugatepassorder,
            iconPath: ImageConstants.imgGatePassOrder,
            // isVisible: checkVisibility(MainCategoryEnum.milk.displayName),
          ),
          MenuItem(
            titleKey: StringConstants.menuconfirmorder,
            iconPath: ImageConstants.imgSelectdRadio,
            // isVisible: checkVisibility(
            //   MainCategoryEnum.dairyProduct.displayName,
            // ),
          ),
        ],
      ),
      MenuGroup(
        titleKey: StringConstants.menuHeaderOrderHistory,
        items: [
          MenuItem(
            titleKey: StringConstants.menuviewpreviousorder,
            iconPath: ImageConstants.imgViewPreviousOrder,
          ),
          MenuItem(
            titleKey: StringConstants.menuviewpreviousextraorder,
            iconPath: ImageConstants.imgViewPreviousExtraOrder,
            isVisible: AppServices.settings.isExtra,
          ),
          MenuItem(
            titleKey: StringConstants.menuviewgatepassorder,
            iconPath: ImageConstants.imgViewGatePassOrder,
            // isVisible: checkVisibility(MainCategoryEnum.milk.displayName),
          ),
        ],
      ),

      // if (!(checkVisibility(MainCategoryEnum.bakery.displayName) ?? false))
      //   MenuGroup(
      //     titleKey: StringConstants.menuHeaderCashManagement,
      //     items: [
      //       MenuItem(
      //         titleKey: StringConstants.menucashentry,
      //         iconPath: ImageConstants.imgCashEntry,
      //       ),
      //       MenuItem(
      //         titleKey: StringConstants.menuviewcashentry,
      //         iconPath: ImageConstants.imgViewCashEntry,
      //       ),
      //     ],
      //   ),
      // if (!(checkVisibility(MainCategoryEnum.dairyProduct.displayName) ??
      //     false))
      //   MenuGroup(
      //     titleKey: StringConstants.menuHeaderReports,
      //     items: [
      //       MenuItem(
      //         titleKey: StringConstants.menudailySlip,
      //         iconPath: ImageConstants.imgDailySlip,
      //         isVisible:
      //             checkVisibility(MainCategoryEnum.milk.displayName) ?? false,
      //       ),
      //       MenuItem(
      //         titleKey: StringConstants.menudatewisebalance,
      //         iconPath: ImageConstants.imgDateWiseBalance,
      //       ),
      //       MenuItem(
      //         titleKey: StringConstants.menuyearlystatement,
      //         iconPath: ImageConstants.imgStateMent,
      //         isVisible:
      //             checkVisibility(MainCategoryEnum.milk.displayName) ?? false,
      //       ),
      //       MenuItem(
      //         titleKey: StringConstants.menucratebalance,
      //         iconPath: ImageConstants.imgStateMent,
      //         isVisible: AppServices.settings.isDistributor,
      //       ),
      //     ],
      //   ),
    ].obs; // 👈 convert list to RxList
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
