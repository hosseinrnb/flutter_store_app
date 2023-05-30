import 'package:dio/dio.dart';
import 'package:flutter_store_app/data/model/product.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class ICategoryProductDatasource {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'category="$categoryId"'};
      Response<dynamic> response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
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
