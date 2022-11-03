import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<bool> setData(
      {required String key, required String value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
    return true;
  }

  static Future<String?> getData({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  static Future<bool> clearData({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
    return true;
  }
}