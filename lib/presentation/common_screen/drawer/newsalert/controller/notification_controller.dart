import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/newsalert/model/notification_model.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/newsalert/respository/notification_repository.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/services/file_download_service/filedownload.dart';
import 'package:sumul_hr/widgets/loading_dialog.dart';
import 'package:sumul_hr/widgets/show_comman_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final RxList<NotificationResponseData> newsList =
      <NotificationResponseData>[].obs;
  final RxInt unReadCount = 0.obs;
  RxBool isLoading = false.obs;
  Rx<NotificationReadUnreadInputModel> inputModel =
      NotificationReadUnreadInputModel().obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotification(); // no need for `await` here
    });
    //loadNews(); // ensure expandedList is synced
  }

  Future<void> getNotification({bool? fromCurrentPage}) async {
    try {
      isLoading.value = true;

      if (!(fromCurrentPage ?? false)) showLoadingDialog();
      var result = await NotificationRepository().getNotification();

      if ((result?.status ?? false)) {
        if (result?.data != null) {
          newsList.value = result?.data ?? [];
          // expandedList.assignAll(List<bool>.filled(newsList.length, false));
          unReadCount.value = newsList
              .where((element) => element.msgStatus?.toLowerCase() == "u")
              .toList()
              .count();

          AppServices.settings.unreadCount = unReadCount.value;

          for (var news in newsList) {
            if (!(AllFunction.isStringNullOrEmptyOrBlank(news.pdfFile ?? ""))) {
              news.url = await convertBase64ToPDF(
                news.pdfFile ?? "",
                news.subject?.replaceAll(' ', '') ?? "",
                isOpen: false,
              );
            }
          }
        }
      }
    } catch (e) {
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
      if (!(fromCurrentPage ?? false)) hideLoadingDialog();
      Future.delayed(Duration.zero, () {
        Get.dialog(
          ShowAleartComman(title: StringConstants.alert, content: e.toString()),
        );
      });
    } finally {
      isLoading.value = false;
      if (!(fromCurrentPage ?? false)) hideLoadingDialog();
    }
  }

  void toggleExpanded(NotificationResponseData currentNews) {
    for (var element in newsList) {
      if (element.trnNo == currentNews.trnNo) {
        element.isExpanded = !(element.isExpanded ?? false);
        if (currentNews.msgStatus?.toLowerCase() == "u") {
          updateStatus(currentNews);
          if (AppServices.settings.unreadCount > 0) {
            AppServices.settings.unreadCount--;
          }
          element.msgStatus = "R";
        }

        // Get.find<DashboardController>().notificationCount.value =
        //     AppServices.settings.unreadCount;
      } else {
        element.isExpanded = false;
      }
    }

    newsList.refresh();
  }

  void updateStatus(NotificationResponseData currentNews) async {
    try {
      inputModel.value.custcd = AppServices.settings.isDistributor
          ? AppServices.settings.selectedDistributor
          : AppServices.settings.selectedAgent;
      inputModel.value.trnno = (currentNews.trnNo ?? 0).toString();
      isLoading.value = true;
      showLoadingDialog();
      var result = await NotificationRepository().updateNotification(
        input: inputModel.value,
      );

      if ((result?.status ?? false)) {}
    } catch (e) {
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
      hideLoadingDialog();
      Future.delayed(Duration.zero, () {
        Get.dialog(
          ShowAleartComman(title: StringConstants.alert, content: e.toString()),
        );
      });
    } finally {
      isLoading.value = false;
      hideLoadingDialog();
    }
  }
}
