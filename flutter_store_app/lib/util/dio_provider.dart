import 'package:dio/dio.dart';
import 'package:flutter_store_app/util/auth_manager.dart';

class DioProvider {
  static Dio creatDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
        headers: {
          'Content-Type': 'appllication/json',
          'Authorization': 'Bearer ${AuthManger.readAuth()}',
        },
      ),
    );
    return dio;
  }

  static Dio creatDioWithoutHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
      ),
    );
    return dio;
  }
}
