//Views are all the Widgets and Pages within the Flutter Application.
// These views may contain a “view controller” themselves,
// but that is still considered part of the view application tier.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/splash/widgets/splash_widget.dart';
import 'package:sumul_hr/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      AppServices.settings.isUserLoggedIn
          ? Get.offAllNamed(
              AppServices.settings.isDistributor
                  ? Routes.DIST_CATEGORY_SCREEN
                  : Routes.CATEGORY_SCREEN,
            )
          : Get.offAllNamed(Routes.AUTH_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: splashView(),
    );
  }
}
