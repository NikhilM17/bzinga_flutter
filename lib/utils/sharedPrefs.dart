import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final String TOKEN = "token";

  static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN).isNotEmpty;
  }

  static saveLocation(String city, String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("city", city);
    prefs.setString("state", state);
  }

  Future<String> getCity() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("city");
    } catch (e) {
      print(e.toString());
    }
  }

  static getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String state = prefs.getString("state");
    return state;
  }
}
