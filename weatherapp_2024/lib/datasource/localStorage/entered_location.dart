import 'package:shared_preferences/shared_preferences.dart';

class EnteredLocation {
  static Future<String> getEnteredLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('enteredLocation') ?? '';
  }

  static Future<void> setEnteredLocation(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('enteredLocation', value);
  }
}
