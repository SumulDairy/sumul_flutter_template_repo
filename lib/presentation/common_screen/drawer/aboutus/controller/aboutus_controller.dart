import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/aboutus/model/aboutus_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutusController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoading = false.obs;
  Rx<AboutUsResponseModel> aboutUsResponse = AboutUsResponseModel().obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAboutUs();
    });
  }

  void makeCall({String? number}) async {
    final Uri callUri = Uri(scheme: 'tel', path: number);

    // Ask permission
    final status = await Permission.phone.request();

    if (status.isGranted) {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        // showErrorDialog("Could not launch phone dialer.");
      }
    } else {
      // showErrorDialog("Phone permission is required to make calls.");
    }
  }

  Future<void> getAboutUs() async {
    // try {
    //   isLoading.value = true;
    //   showLoadingDialog();
    //   var cat = AllFunction.getMainCategoryShortCode();
    //   var result = await AboutusRepository().getAboutUsServiceCall(
    //     categori: cat,
    //   );

    //   if ((result?.status ?? false)) {
    //     aboutUsResponse.value = result ?? AboutUsResponseModel();
    //   } else {
    //     hideLoadingDialog();
    //     await Get.dialog(
    //       ShowAleartComman(
    //         title: StringConstants.alert,
    //         content: result?.message ?? StringConstants.noRecordFound,
    //       ),
    //     );
    //   }
    // } catch (e) {
    //   hideLoadingDialog();
    //   // await Get.dialog(ShowAleartComman(title: "Error", content: e.toString()));
    // } finally {
    //   hideLoadingDialog(); // ✅ Always dismiss in finally
    //   isLoading.value = false;
    // }
  }
}
