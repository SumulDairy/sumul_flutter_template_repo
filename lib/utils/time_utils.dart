import 'package:ntp/ntp.dart';

class TimeUtils {
  static DateTime? _serverTime;

  /// Call this during app launch or resume
  static Future<void> syncTime() async {
    try {
      _serverTime = await NTP.now();
    } catch (e) {
      _serverTime = DateTime.now(); // fallback
    }
  }

  /// Returns current trusted time
  static DateTime now() {
    return _serverTime ?? DateTime.now();
  }

  /// Optional: time difference
  static Duration getTimeOffset() {
    return (_serverTime ?? DateTime.now()).difference(DateTime.now());
  }
}
