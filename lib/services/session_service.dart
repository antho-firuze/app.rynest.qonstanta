import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static SessionService? _instance;

  static Future<SessionService> getInstance() async {
    if (_instance == null) {
      _instance = SessionService._(await SharedPreferences.getInstance());
    }
    return _instance!;
  }

  final SharedPreferences _preferences;
  SessionService._(this._preferences);

  static const _IsFirstRun = 'isFirstRunKey';
  // static const _UserThemeMode = 'user_theme_mode_key';
  static const _UserLangKey = 'user_language_key';
  static const _TokenKey = 'token_key';
  static const _UserFontSizeKey = 'user_font_size_key';
  static const _UserKey = 'user_key';
  static const _SigninTopicKey = 'signin_topic_key';

  Future isFirstRun({bool? value}) async {
    if (value == null)
      return _getFromDisk(_IsFirstRun) ?? true;
    else
      _saveToDisk(_IsFirstRun, value);
  }

  Future lang({String? value}) async {
    if (value == null)
      return _getFromDisk(_UserLangKey) ?? 'id';
    else
      _saveToDisk(_UserLangKey, value);
  }

  Future token({String? value}) async {
    if (value == null)
      return _getFromDisk(_TokenKey) ?? '';
    else
      _saveToDisk(_TokenKey, value);
  }

  Future fontSize({int? value}) async {
    if (value == null)
      return _getFromDisk(_UserFontSizeKey) ?? 16;
    else
      _saveToDisk(_UserFontSizeKey, value);
  }

  Future user({String? value}) async {
    if (value == null)
      return _getFromDisk(_UserKey) ?? '';
    else
      _saveToDisk(_UserKey, value);
  }

  Future signInTopic({String? value}) async {
    if (value == null)
      return _getFromDisk(_SigninTopicKey) ?? '';
    else
      _saveToDisk(_SigninTopicKey, value);
  }

  void clearPreferences() {
    _preferences.clear();
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void _saveToDisk(String key, dynamic content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
