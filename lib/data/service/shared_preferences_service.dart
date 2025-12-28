import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferencesAsync _sharedPreferencesAsync;

  SharedPreferencesService(SharedPreferencesAsync sharedPreferencesAsync)
    : _sharedPreferencesAsync = sharedPreferencesAsync;

  Future<void> setString(String key, String value) async {
    return await _sharedPreferencesAsync.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return await _sharedPreferencesAsync.getString(key);
  }
}
