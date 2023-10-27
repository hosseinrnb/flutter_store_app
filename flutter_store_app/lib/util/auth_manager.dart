import 'package:flutter/cupertino.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManger {
  static final ValueNotifier authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static void saveId(String id) async {
    _sharedPref.setString('user_id', id);
  }

  static String getId() {
    return _sharedPref.getString('user_id') ?? '';
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }
}
