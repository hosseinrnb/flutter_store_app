import 'package:flutter/cupertino.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManger{

  static final ValueNotifier authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

}