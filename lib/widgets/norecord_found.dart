import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sumul_hr/resources/app_image_assets.dart';

class NoRecordFoundView extends StatelessWidget {
  final String? message;

  const NoRecordFoundView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        ImageConstants.lotnorecordFound,
        repeat: true,
        height: Get.height * 0.3,
      ),
    );
  }
}
