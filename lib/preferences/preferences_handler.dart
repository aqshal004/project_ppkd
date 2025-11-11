import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHandler {
  static const String isLogin = "isLogin";
  static const String lastPageIndex = "lastPageIndex";
  static const String userName = "userName";
  static const String userEmail = "userEmail";


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

  static Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

  static Future<void> saveRole(String role) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('role', role);
}

static Future<String?> getRole() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}


  // Simpan index halaman terakhir
  // static saveLastPageIndex(int index) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(lastPageIndex, index);
  // }

  //  // Ambil index halaman terakhir
  // static Future<int> getLastPageIndex() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(lastPageIndex) ?? 0; // Default 0 (Dashboard)
  // }

  // Simpan data user
  static saveUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userName, name);
    prefs.setString(userEmail, email);
  }

  // Ambil data user
  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(userName),
      'email': prefs.getString(userEmail),
    };
  }
}