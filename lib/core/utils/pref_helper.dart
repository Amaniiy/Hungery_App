/*import 'package:shared_preferences/shared_preferences.dart';

//الفايل دا عشان احفظ اليوزر توكن في الشيرد بريفيرنس
class PrefHelper {
  static const String _tokenKey = 'auth_token';
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.get(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
*/
