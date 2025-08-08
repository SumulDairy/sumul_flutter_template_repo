import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumul_transport/services/shared_preference/shared_pref_key.dart';

class Settings {
  //   static Settings? _settings;
  final SharedPreferences? _preferences;

  // static Future<Settings?> getInstance() async {
  //   if (_settings == null) {
  //     final secureStorage = AppServices.settings._();
  //     await secureStorage._init();
  //     _settings = secureStorage;
  //   }
  //   return _settings;
  // }

  // AppServices.settings._();

  // Future _init() async {
  //   _preferences = await SharedPreferences.getInstance();
  // }
  Settings(this._preferences);

  // static Future<void> init() async {
  //   _preferences = await SharedPreferences.getInstance();
  // }

  String get empNo => _preferences?.getString(SharedPrefKey.empNo) ?? "";
  set empNo(String value) =>
      _preferences?.setString(SharedPrefKey.empNo, value);

  bool get isUserLoggedIn =>
      _preferences?.getBool(SharedPrefKey.isUserLoggedIn) ?? false;
  set isUserLoggedIn(bool value) =>
      _preferences?.setBool(SharedPrefKey.isUserLoggedIn, value);

  bool get isUserFirstTime =>
      _preferences?.getBool(SharedPrefKey.isUserFirstTime) ?? true;
  set isUserFirstTime(bool value) =>
      _preferences?.setBool(SharedPrefKey.isUserFirstTime, value);

  String get accessToken =>
      _preferences?.getString(SharedPrefKey.accessToken) ?? "";
  set accessToken(String value) =>
      _preferences?.setString(SharedPrefKey.accessToken, value);

  String get name => _preferences?.getString(SharedPrefKey.name) ?? "";
  set name(String value) => _preferences?.setString(SharedPrefKey.name, value);

  String get mobileNo => _preferences?.getString(SharedPrefKey.mobileNo) ?? "";
  set mobileNo(String value) =>
      _preferences?.setString(SharedPrefKey.mobileNo, value);

  String get userId => _preferences?.getString(SharedPrefKey.userId) ?? "";
  set userId(String value) =>
      _preferences?.setString(SharedPrefKey.userId, value);

  String get fcmToken => _preferences?.getString(SharedPrefKey.fcmToken) ?? "";
  set fcmToken(String value) =>
      _preferences?.setString(SharedPrefKey.fcmToken, value);

  String get firstName =>
      _preferences?.getString(SharedPrefKey.firstName) ?? "";
  set firstName(String value) =>
      _preferences?.setString(SharedPrefKey.firstName, value);

  String get lastName => _preferences?.getString(SharedPrefKey.lastName) ?? "";
  set lastName(String value) =>
      _preferences?.setString(SharedPrefKey.lastName, value);

  String get email => _preferences?.getString(SharedPrefKey.email) ?? "";
  set email(String value) =>
      _preferences?.setString(SharedPrefKey.email, value);

  // Localization Support
  String get languageCode =>
      _preferences?.getString(SharedPrefKey.languagecode) ??
      SharedPrefKey.langEnglishCode;
  set languageCode(String value) =>
      _preferences?.setString(SharedPrefKey.languagecode, value);

  String get selectedMainCategory =>
      _preferences?.getString(SharedPrefKey.selectedMainCategory) ?? '';
  set selectedMainCategory(String value) =>
      _preferences?.setString(SharedPrefKey.selectedMainCategory, value);

  String get selectedAgent =>
      _preferences?.getString(SharedPrefKey.selectedAgent) ?? '';
  set selectedAgent(String value) =>
      _preferences?.setString(SharedPrefKey.selectedAgent, value);

  String get selectedDistributor =>
      _preferences?.getString(SharedPrefKey.selectedDistributor) ?? '';
  set selectedDistributor(String value) =>
      _preferences?.setString(SharedPrefKey.selectedDistributor, value);

  String get selectedAgentName =>
      _preferences?.getString(SharedPrefKey.selectedAgentName) ?? '';
  set selectedAgentName(String value) =>
      _preferences?.setString(SharedPrefKey.selectedAgentName, value);

  String get agentBalance =>
      _preferences?.getString(SharedPrefKey.agentBalance) ?? '';
  set agentBalance(String value) =>
      _preferences?.setString(SharedPrefKey.agentBalance, value);

  bool get isExtra => _preferences?.getBool(SharedPrefKey.isExtra) ?? false;
  set isExtra(bool value) =>
      _preferences?.setBool(SharedPrefKey.isExtra, value);

  String get shift => _preferences?.getString(SharedPrefKey.shift) ?? '';
  set shift(String value) =>
      _preferences?.setString(SharedPrefKey.shift, value);

  String get deviceInfo =>
      _preferences?.getString(SharedPrefKey.deviceInfo) ?? '';
  set deviceInfo(String value) =>
      _preferences?.setString(SharedPrefKey.deviceInfo, value);

  List<int> get shownNotificationIds {
    final list =
        _preferences?.getStringList(SharedPrefKey.shownNotificationIds) ?? [];
    return list.map(int.parse).toList();
  }

  set shownNotificationIds(List<int> value) {
    final stringList = value.map((e) => e.toString()).toList();
    _preferences?.setStringList(SharedPrefKey.shownNotificationIds, stringList);
  }

  int get unreadCount => _preferences?.getInt(SharedPrefKey.unreadCount) ?? 0;
  set unreadCount(int value) =>
      _preferences?.setInt(SharedPrefKey.unreadCount, value);
  String get custType => _preferences?.getString(SharedPrefKey.custType) ?? '';
  set custType(String value) =>
      _preferences?.setString(SharedPrefKey.custType, value);

  String get orderTimeWindowJson =>
      _preferences?.getString(SharedPrefKey.orderTimeWindowJson) ?? '';

  set orderTimeWindowJson(String value) =>
      _preferences?.setString(SharedPrefKey.orderTimeWindowJson, value);

  String get nextOrderNotifyTime =>
      _preferences?.getString(SharedPrefKey.nextOrderNotifyTime) ?? '';

  set nextOrderNotifyTime(String value) =>
      _preferences?.setString(SharedPrefKey.nextOrderNotifyTime, value);

  bool get isOrderTimeFetched =>
      _preferences?.getBool(SharedPrefKey.isOrderTimeFetched) ?? false;

  set isOrderTimeFetched(bool value) =>
      _preferences?.setBool(SharedPrefKey.isOrderTimeFetched, value);

  bool get isDistributor =>
      _preferences?.getBool(SharedPrefKey.isDistributor) ?? false;

  set isDistributor(bool value) =>
      _preferences?.setBool(SharedPrefKey.isDistributor, value);

  List<String> get listOfDistributor {
    final list =
        _preferences?.getStringList(SharedPrefKey.listOfDistributor) ?? [];
    return list;
  }

  set listOfDistributor(List<String> value) {
    final stringList = value.map((e) => e.toString()).toList();
    _preferences?.setStringList(SharedPrefKey.listOfDistributor, stringList);
  }

  List<int> get listOfDistributorAgent {
    final list =
        _preferences?.getStringList(SharedPrefKey.listOfDistributorAgent) ?? [];
    return list.map(int.parse).toList();
  }

  set listOfDistributorAgent(List<int> value) {
    final stringList = value.map((e) => e.toString()).toList();
    _preferences?.setStringList(
      SharedPrefKey.listOfDistributorAgent,
      stringList,
    );
  }

  Future<void> clear() async {
    await _preferences?.clear();
  }
}
