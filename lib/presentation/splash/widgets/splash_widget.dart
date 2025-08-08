// A function is a subset of an algorithm that is logically separated and reusable.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_transport/resources/app_image_assets.dart';
import 'package:sumul_transport/utils/app_size_constant.dart';

Widget splashView() {
  return Stack(
    children: [
      Center(
        child: Image.asset(
          ImageConstants.imgLogo,
          height: Sizer.height(Get.size.height * 0.13),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Image.asset(ImageConstants.imgSplshBottom),
      ),
    ],
  );
}
