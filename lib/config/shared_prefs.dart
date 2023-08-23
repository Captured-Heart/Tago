import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? prefs;

//! INITIALIZE PREF
  static void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

//! CLEAR PREFS
  static void clearPrefs() async {
    await prefs?.clear();
  }

//! set true to check for onBoarding
  static void setOnBoardingSeen() {
    prefs?.setBool('seen', true);
  }

  static bool getOnBoardingSeen() {
    bool seenIstTime = prefs?.getBool('seen') ?? false;
    return seenIstTime;
  }
}
