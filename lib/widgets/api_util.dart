import 'package:shared_preferences/shared_preferences.dart';

class ApiUtil {
  static const String BASE_URL = 'http://app.channab.com';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<Map<String, String>> getHeaders() async {
    String? token = await getToken();
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token != null ? 'Token $token' : '',
    };
  }
}
