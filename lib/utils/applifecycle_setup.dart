import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sumul_hr/common/functions.dart';

// final _fetchNotifier = Fetchnotification();

void setupAppLifecycle() {
  AppLifecycleState? lastState;

  SystemChannels.lifecycle.setMessageHandler((msg) async {
    final currentState = AppLifecycleState.values.firstWhere(
      (e) => e.toString() == msg,
      orElse: () => AppLifecycleState.resumed,
    );

    if (lastState != AppLifecycleState.resumed &&
        currentState == AppLifecycleState.resumed) {
      AllFunction.safeLog("🔁 App resumed → fetching notifications");
      // await _fetchNotifier.fetchAndScheduleNotifications();
    }

    lastState = currentState;
    return null;
  });
}
