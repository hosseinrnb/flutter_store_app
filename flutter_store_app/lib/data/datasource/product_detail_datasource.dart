import 'package:dio/dio.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class IDetailProductDatasource {
  Future<List<ProductImage>> getGallery();
}


class DetailProductRemoteDatasource extends IDetailProductDatasource{

  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery() async {
    try {
      
      var response = await _dio.get('collections/gallery/records');
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromMapJson(jsonObject))
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