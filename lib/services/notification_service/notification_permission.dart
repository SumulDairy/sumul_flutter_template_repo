import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

import 'package:sumul_hr/common/functions.dart';

class NotifPermission {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidImplementation = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      final granted = await androidImplementation
          ?.requestNotificationsPermission();
      AllFunction.safeLog(
        "🔔 Android Notification Permission Granted: $granted",
      );
    } else if (Platform.isIOS) {
      final iosImplementation = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();

      final granted = await iosImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      AllFunction.safeLog("🔔 iOS Notification Permission Granted: $granted");
    }
  }
}
