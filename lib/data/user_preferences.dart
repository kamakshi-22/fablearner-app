import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  // Define keys for user data fields
  static const _keyUserToken = 'user_token';
  static const _keyUserDisplayName = 'user_display_name';
  static const _keyUserEmail = 'user_email';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  // Methods to set and get User data fields

  /* Token */
  static setUserToken(String token) async =>
      _preferences.setString(_keyUserToken, token);

  static getUserToken() => _preferences.getString(_keyUserToken);

  /* Display name */
  static setUserDisplayName(String displayName) async =>
      await _preferences.setString(_keyUserDisplayName, displayName);

  static String? getUserDisplayName() =>
      _preferences.getString(_keyUserDisplayName);

  /* Email */
  static setUserEmail(String email) async =>
      await _preferences.setString(_keyUserEmail, email);

  static String? getUserEmail() => _preferences.getString(_keyUserEmail);

  // Remove user data
  static void clearUserDetails() async {
    await _preferences.remove(_keyUserToken);
    await _preferences.remove(_keyUserDisplayName);
    await _preferences.remove(_keyUserEmail);
    // Add more preferences to remove if needed
  }
}
