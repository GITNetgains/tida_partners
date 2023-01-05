import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  //appended bundle id to make sure preference is unique for each flavour
  static const TOKEN_KEY = "TOKEN_KEY";
  static const USER_ID = "USER_ID";
  static const USER_DATA = "USER_DATA";
  static const IS_LOGGEDIN = "IS_LOGGEDIN";

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setToken(String token) async {
    return await _prefs.setString(TOKEN_KEY, token);
  }

  static Future<bool> setLoggedIn(bool token) async {
    return await _prefs.setBool(IS_LOGGEDIN, token);
  }

  static Future<bool> setUserId(String data) async {
    return await _prefs.setString(USER_ID, data);
  }

  static Future<bool> setUserData(String time) async {
    return await _prefs.setString(USER_DATA, time);
  }

  static String getToken() => _prefs.getString(TOKEN_KEY) ?? "";

  static String getUserId() => _prefs.getString(USER_ID) ?? "";

  static String getUserData() => _prefs.getString(USER_DATA) ?? "";
  static bool getLoggedIn() => _prefs.getBool(IS_LOGGEDIN)??false;
}
