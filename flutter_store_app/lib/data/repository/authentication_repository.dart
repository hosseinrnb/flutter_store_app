import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/authentication_datasource.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/util/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class IAuthRepository{
  Future<Either<String,String>> register(String username, String password, String passwordConfirm);

  Future<Either<String,String>> login(String username, String password);
}



class AuthenticationRepository implements IAuthRepository{
  final IAuthenticationDatasource _datasource = locator.get();
  final SharedPreferences _sharedPref = locator.get();
  
  @override
  Future<Either<String, String>> register(String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register('Hosseinali', '12345678', '12345678');
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
  
  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        _sharedPref.setString('access_token',token);
        return right('شما با موفقیت وارد شدید');
      } else {
        return left('شما وارد نشدید');
      }
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  
}