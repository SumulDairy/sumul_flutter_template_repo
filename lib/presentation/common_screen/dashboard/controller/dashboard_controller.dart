import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/model/dashboard_model.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/utils/time_utils.dart';
import 'package:sumul_hr/widgets/show_comman_alert.dart';

class DashboardController extends GetxController {
  final RxList<MenuGroup> menuGroups = <MenuGroup>[].obs;
  RxBool isDrawerOpen = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<OrderTimeWindow> orderWindows = <OrderTimeWindow>[].obs;
  RxString shiftWiseCompletedMessage = ''.obs;
  RxInt notificationCount = AppServices.settings.unreadCount.obs;

  var isConnected = RxBool(true);
  var isLoading = RxBool(false);
  final RxString currentTime = ''.obs;
  late Timer _timer;
  @override
  void onInit() {
    super.onInit();
    // if (!(AppServices.settings.isOrderTimeFetched)) {
    loadTime();
    // }
    // Reactively sync unread count
    ever(AppServices.settings.unreadCount.obs, (val) {
      notificationCount.value = val;
      update(["updateCount"]);
    });
    getCurrentTime();
    // Use model directly

    menuGroups.value = AllFunction.getMenus();
    menuGroups.first.isExpanded = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getCurrentTime();
    });
  }

  Future<void> loadTime() async {
    try {
      var connected = await AllFunction.checkConnectivity();
      if (connected) {
        isLoading.value = true;

        var result =
            // await DashboardRepository().getOrderTimeServiceCall() ??
            OrderTimeWindowResponseModel();

        if ((result.status ?? false)) {
          if (result.data != null) {
            isLoading.value = false;

            AppServices.settings.orderTimeWindowJson = json.encode(
              result.toJson(),
            );
            // getLoadOrderTime();
          }
          AppServices.settings.isOrderTimeFetched = true;
        } else {
          isLoading.value = false;
          await Get.dialog(
            ShowAleartComman(
              title: StringConstants.error.capitalize ?? "",
              content: result.message!,
            ),
          );
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
    }
  }

  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void toggleExpansion(int index) {
    menuGroups[index].isExpanded = !menuGroups[index].isExpanded;
    menuGroups.refresh();
  }

  void selectMenu(String title) async {
    // switch (title) {
    //   // Order Management

    //   case StringConstants.menuplaceOrder:
    //     // if (shiftWiseCompletedMessage.isNotEmpty) {
    //     //   return;
    //     // }
    //     _timer.cancel();
    //     if ((AppServices.settings.selectedMainCategory ==
    //         MainCategoryEnum.milk.displayName)) {
    //       AppServices.settings.shift = "M";

    //       Get.toNamed(
    //         AppServices.settings.isDistributor
    //             ? Routes.DIST_PLACE_ORDER_SCREEN
    //             : Routes.PLACE_ORDER_SCREEN,
    //       )?.then((value) {
    //         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //           getCurrentTime();
    //         });
    //       });
    //     } else {
    //       Get.toNamed(Routes.AGENT_PRODUCTCATEGORY_SCREEN)?.then((value) {
    //         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //           getCurrentTime();
    //         });
    //       });
    //     }
    //     break;

    //   case StringConstants.menucopyOrder:
    //     // if (shiftWiseCompletedMessage.isNotEmpty) {
    //     //   return;
    //     // }
    //     AppServices.settings.shift = "M";
    //     _timer.cancel();
    //     if ((AppServices.settings.selectedMainCategory ==
    //         MainCategoryEnum.milk.displayName)) {
    //       Get.toNamed(Routes.COPY_ORDER_SCREEN)?.then((value) {
    //         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //           getCurrentTime();
    //         });
    //       });
    //     } else if ((AppServices.settings.selectedMainCategory ==
    //         MainCategoryEnum.bakery.displayName)) {
    //       Get.toNamed(Routes.BK_COPY_ORDER_SCREEN)?.then((value) {
    //         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //           getCurrentTime();
    //         });
    //       });
    //     } else {
    //       Get.toNamed(Routes.DP_COPY_ORDER_SCREEN)?.then((value) {
    //         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //           getCurrentTime();
    //         });
    //       });
    //     }

    //     break;

    //   case StringConstants.menuextraorder:
    //     // if ((shiftWiseCompletedMessage.isNotEmpty) &&
    //     //     (AppServices.settings.shift != ShiftEnum.M.name)) {
    //     //   return;
    //     // }
    //     _timer.cancel();
    //     var prev = AppServices.settings.shift;
    //     AppServices.settings.shift = ShiftEnum.T.name;
    //     Get.toNamed(Routes.EXTRA_ORDER_SCREEN)?.then((value) {
    //       AppServices.settings.shift = prev;
    //       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //         getCurrentTime();
    //       });
    //     });
    //     break;

    //   case StringConstants.menubakeryorder:
    //     // if (shiftWiseCompletedMessage.isNotEmpty) {
    //     //   return;
    //     // }
    //     //Get.toNamed(Routes.BAKERY_ORDER);
    //     break;

    //   case StringConstants.menugatepassorder:
    //     _timer.cancel();
    //     var prev = AppServices.settings.shift;
    //     AppServices.settings.shift = ShiftEnum.G.name;
    //     Get.toNamed(
    //       AppServices.settings.isDistributor
    //           ? Routes.DIST_GATEPASS_ORDER_SCREEN
    //           : Routes.GATEPASS_ORDER_SCREEN,
    //     )?.then((value) {
    //       AppServices.settings.shift = prev;
    //       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //         getCurrentTime();
    //       });
    //     });
    //     break;

    //   case StringConstants.menuconfirmorder:
    //     _timer.cancel();
    //     Get.toNamed(Routes.DP_CONFIRM_ORDER_SCREEN)?.then((value) {
    //       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //         getCurrentTime();
    //       });
    //     });
    //     break;

    //   // Order History
    //   case StringConstants.menuviewpreviousorder:
    //     if ((AppServices.settings.selectedMainCategory ==
    //         MainCategoryEnum.milk.displayName)) {
    //       Get.toNamed(
    //         AppServices.settings.isDistributor
    //             ? Routes.DIST_VIEW_PREVIOUS_PLACE_ORDER_SCREEN
    //             : Routes.VIEW_PREVIOUS_PLACE_ORDER_SCREEN,
    //       );
    //     } else if ((AppServices.settings.selectedMainCategory ==
    //         MainCategoryEnum.bakery.displayName)) {
    //       Get.toNamed(Routes.BK_VIEW_PREVIOUS_PLACE_ORDER_SCREEN);
    //     } else {
    //       Get.toNamed(Routes.DP_VIEW_PREVIOUS_PLACE_ORDER_SCREEN);
    //     }

    //     break;

    //   case StringConstants.menuviewpreviousextraorder:
    //     Get.toNamed(Routes.VIEW_PREVIOUS_EXTRA_ORDER_SCREEN);
    //     break;

    //   case StringConstants.menuviewgatepassorder:
    //     Get.toNamed(
    //       AppServices.settings.isDistributor
    //           ? Routes.DIST_VIEW_PREVIOUS_GATEPASS_ORDER_SCREEN
    //           : Routes.VIEW_PREVIOUS_GATEPASS_ORDER_SCREEN,
    //     );
    //     break;

    //   // Cash Management
    //   case StringConstants.menucashentry:
    //     Get.toNamed(Routes.CASH_ENTRY_SCREEN);
    //     break;

    //   case StringConstants.menuviewcashentry:
    //     Get.toNamed(Routes.CASH_ENTRY_VIEW_SCREEN);
    //     break;

    //   // Reports
    //   case StringConstants.menudailySlip:
    //     Get.toNamed(Routes.DAILY_SLIP_SCREEN);
    //     break;

    //   case StringConstants.menudatewisebalance:
    //     if ((AppServices.settings.selectedMainCategory ==
    //         MainCategoryEnum.bakery.displayName)) {
    //       Get.toNamed(Routes.BK_DATEWISE_BALANCE_SCREEN);
    //     } else {
    //       Get.toNamed(Routes.DATEWISE_BALANCE_SCREEN);
    //     }

    //     break;

    //   case StringConstants.menuyearlystatement:
    //     Get.toNamed(Routes.STATEMENT_SCREEN);
    //     break;

    //   case StringConstants.menupricelist:
    //     priceListSection();

    //     break;
    //   case StringConstants.menunewsalert:
    //     Get.toNamed(Routes.NOTIFICATION_SCREEN);
    //     break;

    //   // Settings
    //   case StringConstants.menuchangepassword:
    //     Get.toNamed(Routes.CHANGEPASSWORD_SCREEN);
    //     break;

    //   case StringConstants.menuaboutus:
    //     Get.toNamed(Routes.ABOUTUS_SCREEN);
    //     break;
    //   case StringConstants.logout:
    //     Get.offNamedUntil(Routes.CATEGORY_SCREEN, (route) => false);

    //     break;
    //   case StringConstants.menubacktocategory:
    //     Get.offNamedUntil(Routes.CATEGORY_SCREEN, (route) => false);

    //     break;

    //   case StringConstants.menucratebalance:
    //     Get.toNamed(Routes.DIST_CRATE_BALANCE_SCREEN);
    //     break;

    //   default:
    //     Get.snackbar('Error', 'Menu not implemented');
    // }
  }

  void getCurrentTime() {
    TimeUtils.syncTime();
    currentTime.value = DateFormat('hh:mm:ss a').format(TimeUtils.now());

  }
}
