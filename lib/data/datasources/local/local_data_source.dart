import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences _prefs;

  LocalDataSource(this._prefs);

  // Keys
  static const String _keyToken = 'auth_token';
  static const String _keyUserId = 'user_id';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLocale = 'locale';
  static const String _keyOnboardingCompleted = 'onboarding_completed';

  // Token
  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  Future<void> deleteToken() async {
    await _prefs.remove(_keyToken);
  }

  // User ID
  Future<void> saveUserId(String userId) async {
    await _prefs.setString(_keyUserId, userId);
  }

  String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

  Future<void> deleteUserId() async {
    await _prefs.remove(_keyUserId);
  }

  // Theme Mode
  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(_keyThemeMode, themeMode);
  }

  String? getThemeMode() {
    return _prefs.getString(_keyThemeMode);
  }

  // Locale
  Future<void> saveLocale(String locale) async {
    await _prefs.setString(_keyLocale, locale);
  }

  String? getLocale() {
    return _prefs.getString(_keyLocale);
  }

  // Onboarding
  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_keyOnboardingCompleted, true);
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  // Clear all
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
