
class Fetchnotification {
  // final RxBool isLoading = false.obs;

  // OrderTimeWindow? _findNextShift(List<OrderTimeWindow> list) {
  //   final now = DateTime.now();
  //   final currentCategory = AllFunction.getMainCategoryName().toLowerCase();

  //   final filtered = list
  //       .where(
  //         (item) =>
  //             item.ordertype?.toLowerCase().trim() == currentCategory &&
  //             item.end != null &&
  //             item.shift != null,
  //       )
  //       .toList();

  //   OrderTimeWindow? next;
  //   // DateTime nextNotify = now;
  //   for (final item in filtered) {
  //     final start = item.parsedStartTimeWithDate(now);
  //     final end = item.parsedEndTimeWithDate(now);
  //     final notifyTime = end.subtract(const Duration(minutes: 15));

  //     if (notifyTime.isAfter(now)) {
  //       // nextNotify =
  //       //     next?.fixedEndTime?.subtract(const Duration(minutes: 15)) ??
  //       //     DateTime(9999);
  //       // if (notifyTime.isBefore(nextNotify)) {
  //       //   next = item.copyWithParsedTimes(startTime: start, endTime: end);
  //       // }
  //       final currentNextNotify =
  //           next?.fixedEndTime?.subtract(const Duration(minutes: 15)) ??
  //           DateTime(9999);
  //       if (notifyTime.isBefore(currentNextNotify)) {
  //         next = item.copyWithParsedTimes(startTime: start, endTime: end);
  //       }
  //     }
  //   }
  //   if (next != null &&
  //       !(AllFunction.isStringNullOrEmptyOrBlank(
  //         next.fixedEndTime.toString(),
  //       ))) {
  //     final nextNotify = next.fixedEndTime!.subtract(
  //       const Duration(minutes: 15),
  //     );
  //     AppServices.settings.nextOrderNotifyTime = nextNotify.toIso8601String();

  //     AllFunction.safeLog(
  //       "Notification : Today ${next.fixedEndTime?.toIso8601String()}",
  //     );
  //     return next;
  //   }

  //   if (filtered.isNotEmpty) {
  //     filtered.sort(
  //       (a, b) => a
  //           .parsedStartTimeWithDate(now)
  //           .compareTo(b.parsedStartTimeWithDate(now)),
  //     );

  //     final first = filtered.first;
  //     final tomorrow = now.add(const Duration(days: 1));
  //     final start = first.parsedStartTimeWithDate(tomorrow);
  //     final end = first.parsedEndTimeWithDate(tomorrow);

  //     // // AllFunction.safeLog("Notification : Next ${end.toIso8601String()}");
  //     // AppServices.settings.nextOrderNotifyTime = end.toIso8601String();
  //     // AllFunction.safeLog(
  //     //   "Notification : Tommorrow ${next?.fixedEndTime?.toIso8601String()}",
  //     // );
  //     // return first.copyWithParsedTimes(startTime: start, endTime: end);
  //     final tomorrowShift = first.copyWithParsedTimes(
  //       startTime: start,
  //       endTime: end,
  //     );

  //     AppServices.settings.nextOrderNotifyTime =
  //         tomorrowShift.fixedEndTime
  //             ?.subtract(const Duration(minutes: 15))
  //             .toIso8601String() ??
  //         "";

  //     AllFunction.safeLog(
  //       "Notification : Tommorrow ${tomorrowShift.fixedEndTime?.toIso8601String()}",
  //     );

  //     return tomorrowShift;
  //   }

  //   return null;
  // }

  // Future<void> fetchAndScheduleNotifications() async {
  //   try {
  //     if (AllFunction.isStringNullOrEmptyOrBlank(AppServices.settings.userId)) {
  //       return;
  //     }

  //     isLoading.value = true;
  //     if (!AppServices.settings.isDistributor) {
  //       final prefsTime = AppServices.settings.nextOrderNotifyTime;

  //       if ((!(AllFunction.isStringNullOrEmptyOrBlank(
  //             AppServices.settings.shift,
  //           ))) &&
  //           (!(AllFunction.isStringNullOrEmptyOrBlank(
  //             AppServices.settings.selectedMainCategory,
  //           )))) {
  //         if (AllFunction.isStringNullOrEmptyOrBlank(prefsTime)) {
  //           var result = await DashboardRepository.getOrderStatus();
  //           final jsonStr = AppServices.settings.orderTimeWindowJson;
  //           if (jsonStr.isNotEmpty) {
  //             final model = OrderTimeWindowResponseModel.fromJson(
  //               json.decode(jsonStr),
  //             );
  //             final next = _findNextShift(model.data ?? []);

  //             if (next != null) {
  //               // final nextNotifyTime = next.fixedEndTime?.subtract(
  //               //   const Duration(minutes: 15),
  //               // );

  //               final nextNotifyTime = next.fixedEndTime != null
  //                   ? next.fixedEndTime!.subtract(const Duration(minutes: 15))
  //                   : next
  //                         .parsedEndTimeWithDate(DateTime.now())
  //                         .subtract(const Duration(minutes: 15));

  //               // final nextNotifyTime = next.fixedEndTime?.subtract(
  //               //   const Duration(minutes: 15),
  //               // );
  //               AppServices.settings.nextOrderNotifyTime = nextNotifyTime
  //                   .toIso8601String();
  //               if (result?.status ?? false) {
  //                 var title =
  //                     (AppServices.settings.languageCode ==
  //                         StringConstants.langEnglishCode)
  //                     ? result?.data?.titleE
  //                     : (AppServices.settings.languageCode ==
  //                           StringConstants.langGujaratiCode)
  //                     ? result?.data?.titleG
  //                     : result?.data?.titleH;
  //                 var message =
  //                     (AppServices.settings.languageCode ==
  //                         StringConstants.langEnglishCode)
  //                     ? result?.data?.msgE
  //                     : (AppServices.settings.languageCode ==
  //                           StringConstants.langGujaratiCode)
  //                     ? result?.data?.msgG
  //                     : result?.data?.msgH;
  //                 await NotificationService().scheduleNotificationWithPayload(
  //                   id: 2001,
  //                   title: '⏰ $title',
  //                   body: message ?? "",
  //                   scheduledTime: nextNotifyTime,
  //                   channelId: 'order_channel_id',
  //                   channelName: 'Order Notifications',
  //                   payload: jsonStr,
  //                 );

  //                 AllFunction.safeLog(
  //                   "Notification : Scheduled From 1st Time next notification at ${nextNotifyTime.toIso8601String()}",
  //                 );
  //               }
  //             }
  //           }
  //         } else {
  //           final notifyTime = DateTime.tryParse(prefsTime);
  //           if (notifyTime == null) return;

  //           final jsonStr = AppServices.settings.orderTimeWindowJson;
  //           if (jsonStr.isNotEmpty) {
  //             final model = OrderTimeWindowResponseModel.fromJson(
  //               json.decode(jsonStr),
  //             );
  //             final next = _findNextShift(model.data ?? []);

  //             if (next != null) {
  //               final nextNotifyTime = next.fixedEndTime != null
  //                   ? next.fixedEndTime!.subtract(const Duration(minutes: 15))
  //                   : next
  //                         .parsedEndTimeWithDate(DateTime.now())
  //                         .subtract(const Duration(minutes: 15));

  //               // final nextNotifyTime = next.fixedEndTime?.subtract(
  //               //   const Duration(minutes: 15),
  //               // );

  //               AppServices.settings.nextOrderNotifyTime = nextNotifyTime
  //                   .toIso8601String();
  //               var result = await DashboardRepository.getOrderStatus();
  //               if (result?.status ?? false) {
  //                 var title =
  //                     (AppServices.settings.languageCode ==
  //                         StringConstants.langEnglishCode)
  //                     ? result?.data?.titleE
  //                     : (AppServices.settings.languageCode ==
  //                           StringConstants.langGujaratiCode)
  //                     ? result?.data?.titleG
  //                     : result?.data?.titleH;
  //                 var message =
  //                     (AppServices.settings.languageCode ==
  //                         StringConstants.langEnglishCode)
  //                     ? result?.data?.msgE
  //                     : (AppServices.settings.languageCode ==
  //                           StringConstants.langGujaratiCode)
  //                     ? result?.data?.msgG
  //                     : result?.data?.msgH;
  //                 await NotificationService().scheduleNotificationWithPayload(
  //                   id: 2001,
  //                   title: '⏰ $title',
  //                   body: message ?? "",
  //                   scheduledTime: nextNotifyTime,
  //                   channelId: 'order_channel_id',
  //                   channelName: 'Order Notifications',
  //                   payload: jsonStr,
  //                 );

  //                 AllFunction.safeLog(
  //                   "Notification : Scheduled next notification at  ${nextNotifyTime.toIso8601String()}",
  //                 );
  //               }
  //               // await NotificationService().scheduleNotificationWithPayload(
  //               //   id: 2001,
  //               //   title: '⏰ Order Reminder',
  //               //   body: nextNotifyTime.toIso8601String(),
  //               //   scheduledTime: nextNotifyTime,
  //               //   channelId: 'order_channel_id',
  //               //   channelName: 'Order Notifications',
  //               //   payload: jsonStr,
  //               // );

  //               // AllFunction.safeLog(
  //               //   "Notification : Scheduled next notification at ${nextNotifyTime.toIso8601String()}",
  //               // );
  //             }
  //           }
  //         }
  //       }
  //     }

  //     final result = await NotificationRepository().getNotification();
  //     if (result?.islogout ?? false) {
  //       AllFunction().logoutAll();
  //       AllFunction.logout();
  //       return;
  //     }
  //     final storedIds = AppServices.settings.shownNotificationIds;

  //     final newItems =
  //         result?.data?.where((e) => e.isNew == true).toList() ?? [];

  //     for (final item in newItems) {
  //       final id = item.trnNo;
  //       if (!storedIds.contains(id)) {
  //         await NotificationService.showInstantNotification(
  //           item.subject ?? "📢 New Alert",
  //           item.message ?? "",
  //         );

  //         AllFunction.safeLog("🔔 Notification sent for: ${item.subject}");
  //         storedIds.add(id ?? 0);
  //       }
  //     }

  //     AppServices.settings.unreadCount =
  //         result?.data
  //             ?.where((e) => e.msgStatus?.toLowerCase() == "u")
  //             .length ??
  //         0;

  //     AllFunction.safeLog(
  //       "🔔 Unread Count: ${AppServices.settings.unreadCount}",
  //     );
  //     AppServices.settings.shownNotificationIds = storedIds;
  //   } catch (e) {
  //     AllFunction.safeLog("ERROR===>>>>${e.toString()}");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
