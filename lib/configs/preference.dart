import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;

  // les variables des clés

  // Initialiser les preferences
  static Future init() async => _preferences =
      await SharedPreferences.getInstance(); // Obtain shared preferences.

  // Methodes pour garder
  static Future set(String key, String value) async =>
      await _preferences.setString(key, value);

  // Methodes pour recuper
  static String? get(String key) => _preferences.getString(key);
}
