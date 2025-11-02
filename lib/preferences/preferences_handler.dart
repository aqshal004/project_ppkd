import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHandler {
  static const String isLogin = "isLogin";
  // static const String userName = "userName";
  // static const String userEmail = "userEmail";


  static saveLogin(bool value) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(isLogin, value);
}

  static Future<bool?> getLogin() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(isLogin);
}

  static removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(isLogin);
    // prefs.remove(userName);
    // prefs.remove(userEmail);
  }

  // // Simpan data user
  // static saveUserData(String name, String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // prefs.setString(userName, name);
  //   // prefs.setString(userEmail, email);
  // }

  // // Ambil data user
  // static Future<Map<String, String?>> getUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return {
  //     'name': prefs.getString(userName),
  //     'email': prefs.getString(userEmail),
    // };
  }
