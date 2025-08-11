import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumul_hr/services/shared_preference/shared_pref.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Register Settings using SharedPreferences
  getIt.registerSingleton<Settings>(Settings(prefs));
}
