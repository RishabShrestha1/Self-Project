import 'package:shared_preferences/shared_preferences.dart';

class SkipButtonUtil {
  static Future<bool> hasSkipButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skipClicked') ?? false;
  }

  static Future<void> setSkipButtonPressed(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skipClicked', value);
  }
}
