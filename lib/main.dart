import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/appconfig/appconfig.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/setup_locator.dart';
import 'package:sumul_hr/localization/app_localizations.dart';
import 'package:sumul_hr/services/deviceinfo_service/device_info_service.dart';
import 'package:sumul_hr/services/notification_service/notification_services.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/utils/applifecycle_setup.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:velocity_x/velocity_x.dart';

import 'package:sumul_hr/routes/app_routes.dart';
import 'package:sumul_hr/routes/app_bindings.dart';
import 'package:sumul_hr/resources/app_themes.dart';
import 'package:intl/date_symbol_data_local.dart';

// Global timer to keep polling reference
Timer? pollingTimer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // ✅ important

  // Load env file
  const envFile = String.fromEnvironment('ENV', defaultValue: '.env');
  AllFunction.safeLog("🌍 Loading env file: $envFile");
  await dotenv.load(fileName: envFile);

  tz.initializeTimeZones();
  // Initialize local notifications
  await NotificationService.init();
  // Setup service locators
  await setupLocator();

  // Lock portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Device Info
  AppServices.settings.deviceInfo =
      await DeviceInfoService.getDeviceInfoString();

  // 🔔 Immediate check at launch
  // await Fetchnotification().fetchAndScheduleNotifications();

  // App lifecycle observer
  setupAppLifecycle();

  // ⏱️ Start periodic polling
  // AllFunction.startNotificationPolling();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      ensureScreenSize: true,
      splitScreenMode: false,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConfig.appName,

          // Locale setup
          locale: Locale(AppServices.settings.languageCode),
          fallbackLocale: Locale(AppServices.settings.languageCode),
          translations: AppTranslation(),

          // Supported Locales
          supportedLocales: const [Locale('en'), Locale('hi'), Locale('gu')],

          // Localization Delegates
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          // Routes
          initialRoute: Routes.SPLASH_SCREEN,
          getPages: Routes.routes,
          initialBinding: AppBindings(),

          // Transitions
          defaultTransition: Transition.leftToRight,
        );
      },
    ).onTap(() {
      Get.focusScope?.unfocus();
    });
  }
}
