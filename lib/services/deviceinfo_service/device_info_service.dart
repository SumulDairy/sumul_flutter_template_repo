import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:sumul_transport/common/functions.dart';
import 'package:sumul_transport/services/secure_storage/device_id_helper.dart';

class DeviceInfoService {
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getDeviceInfoString() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      AllFunction.safeLog("Device::${androidInfo.model}${androidInfo.id}");
      return "${androidInfo.model}${androidInfo.id}";
    } else if (Platform.isIOS) {
      var isoInfo = await DeviceIdHelper.getDeviceId();
      AllFunction.safeLog("ios Device::$isoInfo");

      return isoInfo;
    }
    return "Unknown Device";
  }
}
