import 'package:dio/dio.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class IBannerDatasource {
  Future<List<MyBanner>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<MyBanner>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<MyBanner>((jsonObject) => MyBanner.fromMapJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
