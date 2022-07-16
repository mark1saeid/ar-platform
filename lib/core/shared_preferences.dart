import 'package:shared_preferences/shared_preferences.dart';
// Shared Pref  ahmed
class CashLogin {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // save the data
  static Future<bool> saveData({
    String key,
    dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return await sharedPreferences.setInt(key, value);
  }

  // get the data from the memory
  static dynamic getData({
    key,
  }) async {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({String key}) async {
    return await sharedPreferences.remove(key);
  }
}
