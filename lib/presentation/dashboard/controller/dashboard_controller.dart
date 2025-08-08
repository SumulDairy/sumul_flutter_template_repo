import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/presentation/create_balance/model/crate_balance_model.dart';
import 'package:sumul_transport/presentation/dashboard/repository/dashboard_repository.dart';
import 'package:sumul_transport/routes/app_routes.dart';
import 'package:sumul_transport/utils/time_utils.dart';
import 'package:sumul_transport/widgets/loading_dialog.dart';
import 'package:sumul_transport/widgets/show_comman_alert.dart';

class DashboardController extends GetxController {
  var isConnected = RxBool(true);
  var isLoading = RxBool(false);
  final RxString currentTime = ''.obs;
  TextEditingController monthController = TextEditingController();
  RxString selectedMonth = "".obs;
  Rx<CrateTransportResponseData> selectedTransport =
      CrateTransportResponseData().obs;
  RxList<CrateTransportResponseData> transportList =
      <CrateTransportResponseData>[].obs;
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();

    // Reactively sync unread count

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTransport();
    });
    setDefaultMonth();

    // transportList.value = [
    //   CrateTransportResponseData(transporter: "7843", vehicle: "5212"),
    //   CrateTransportResponseData(transporter: "14001", vehicle: "5122"),
    //   CrateTransportResponseData(transporter: "14002", vehicle: "1232"),
    //   CrateTransportResponseData(transporter: "14003", vehicle: "3252"),
    //   CrateTransportResponseData(transporter: "14004", vehicle: "9212"),
    //   CrateTransportResponseData(transporter: "14005", vehicle: "3912"),
    //   CrateTransportResponseData(transporter: "14006", vehicle: "6002"),
    //   CrateTransportResponseData(transporter: "14007", vehicle: "7212"),
    //   CrateTransportResponseData(transporter: "7843", vehicle: "5212"),
    //   CrateTransportResponseData(transporter: "14001", vehicle: "5122"),
    //   CrateTransportResponseData(transporter: "14002", vehicle: "1232"),
    //   CrateTransportResponseData(transporter: "14003", vehicle: "3252"),
    //   CrateTransportResponseData(transporter: "14004", vehicle: "9212"),
    //   CrateTransportResponseData(transporter: "14005", vehicle: "3912"),
    //   CrateTransportResponseData(transporter: "14006", vehicle: "6002"),
    //   CrateTransportResponseData(transporter: "14007", vehicle: "7212"),
    // ];
  }

  void getCurrentTime() {
    TimeUtils.syncTime();
    currentTime.value = DateFormat('hh:mm:ss a').format(TimeUtils.now());
  }

  void setDefaultMonth() {
    final now = DateTime.now();
    final currentMonth = DateFormat('MMM-yyyy').format(now).toUpperCase();
    monthController.text = currentMonth;
    selectedMonth.value = currentMonth;
  }

  @override
  void onClose() {
    AllFunction.safeLog("Dashboard disposed, timer cancelled");
    super.onClose();
  }

  Future<void> loadTransport() async {
    try {
      showLoadingDialog();

      var result =
          await DashboardRepository().getTransport() ??
          CrateTransportResponseModel();
      ();
      if (result.status ?? false) {
        transportList.value = result.data ?? [];
      }
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
      AllFunction.safeLog("ERROR===>>>>${e.toString()}");
      await Get.dialog(ShowAleartComman(title: "Error", content: e.toString()));
    } finally {
      hideLoadingDialog(); // ✅ Only closes dialog if it's open
    }
  }

  void showData({
    CrateTransportResponseData? model,
    String? selectedType,
  }) async {
    model?.selectedMonth = selectedMonth.value;
    switch (selectedType) {
      case "Crate":
        Get.toNamed(Routes.cratebalancescreen, arguments: model);
        break;
      case "Ledger":
        Get.toNamed(Routes.ledgerscreen, arguments: model);
        break;
      case "C/D":
        Get.toNamed(Routes.creditdebitscreen, arguments: model);
        break;
    }
  }
}
