import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:sumul_hr/common/functions.dart';
import 'package:sumul_hr/presentation/common_screen/dashboard/model/dashboard_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize local notifications
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    // Android 13+ permission
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// Called automatically when the scheduled notification time hits
  static Future<void> onDidReceiveNotification(
    NotificationResponse response,
  ) async {
    final payload = response.payload;
    if (payload == null) return;
  }

  /// Show an immediate silent notification
  // static Future<void> showInstantNotification(String title, String body) async {
  //   const platformDetails = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'silent_order_channel',
  //       'Silent Order Reminder',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       playSound: false,
  //     ),
  //     iOS: DarwinNotificationDetails(presentAlert: true, presentSound: false),
  //   );

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     body,
  //     platformDetails,
  //     payload: 'instant_notification',
  //   );
  // }

  static Future<void> showInstantNotification(String title, String body) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'Sumul Co-Opration',
        'Instant Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      ),
    );

    AllFunction.safeLog("🔔 Showing instant notification: $title");

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'instant_notification',
    );
  }

  /// Cancel all scheduled notifications
  static Future<void> cancelAll() async {
    debugPrint("🔕 Cancelling all notifications...");
    await flutterLocalNotificationsPlugin.cancelAll();
  }


  /// Schedules the next valid reminder from the provided list
  static Future<void> scheduleNextReminder(List<OrderTimeWindow> list) async {
    // await cancelAll();

    // final now = DateTime.now();
    // final currentCategory = AllFunction.getMainCategoryName().toLowerCase();

    // OrderTimeWindow? next;

    // for (final item in list) {
    //   final type = item.ordertype?.toLowerCase().trim();
    //   final shift = item.shift;
    //   final endStr = item.end;

    //   if (type != currentCategory || shift == null || endStr == null) continue;

    //   final endTime = _parseTime(endStr);
    //   final notifyTime = endTime.subtract(const Duration(minutes: 15));

    //   if (notifyTime.isAfter(now)) {
    //     if (next == null ||
    //         notifyTime.isBefore(
    //           _parseTime(next.end!).subtract(const Duration(minutes: 15)),
    //         )) {
    //       next = item;
    //     }
    //   }
    // }

    // if (next != null) {
    //   final notifyTime = _parseTime(
    //     next.end!,
    //   ).subtract(const Duration(minutes: 15));

    //   await NotificationService().scheduleNotificationWithPayload(
    //     id: 1001,
    //     title: '',
    //     body: '',
    //     scheduledTime: notifyTime,
    //     payload: jsonEncode({'ordertype': next.ordertype, 'shift': next.shift}),
    //     channelId: 'order_reminder',
    //     channelName: 'Order Reminder Channel',
    //   );
    //   AppServices.settings.nextOrderNotifyTime = notifyTime.toIso8601String();

    //   debugPrint("✅ Scheduled next notification at $notifyTime");
    // } else {
    //   debugPrint("⚠️ No valid shifts today. Will schedule on next app open.");
    // }
  }

  /// Schedule a notification with payload (used for auto-checking API)
  Future<void> scheduleNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required String payload,
    required String channelId,
    required String channelName,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Order reminder',
      importance: Importance.max,
      priority: Priority.high,
    );

    final scheduled = tz.TZDateTime.from(scheduledTime, tz.local);
    final now = tz.TZDateTime.now(tz.local);

    if (scheduled.isBefore(now)) {
      debugPrint("❌ Not scheduling: time is in past.");
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      NotificationDetails(android: androidDetails),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
