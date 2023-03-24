import 'package:dio/dio.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/util/api_exception.dart';


abstract class IAuthenticationDatasource{
  Future<void> register(String username, String password, String passwordConfirm);

  Future<String> login(String username, String password);
}



class AuthenticationRemote implements IAuthenticationDatasource{

  final Dio _dio = locator.get();
  
  @override
  Future<void> register(String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });
    } on DioError catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
  
  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post('collections/users/auth-with-password', data: {
      'identity':username,
      'password':password,
    });

    if (response.statusCode == 200) {
      return response.data?['token'];
    }

    } on DioError catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }

    return '';
  }

  

}