//Views are all the Widgets and Pages within the Flutter Application.
// These views may contain a “view controller” themselves,
// but that is still considered part of the view application tier.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/routes/app_routes.dart';

import 'package:sumul_transport/presentation/splash/widgets/splash_widget.dart';
import 'package:sumul_transport/di/di_helper_services.dart';

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
          ? Get.offAllNamed(Routes.dashboardscreen)
          : Get.offAllNamed(Routes.authscreen);
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
