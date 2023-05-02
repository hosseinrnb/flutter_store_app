import 'package:dio/dio.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/data/model/product_variant.dart';
import 'package:flutter_store_app/data/model/variant.dart';
import 'package:flutter_store_app/data/model/variant_type.dart';
import 'package:flutter_store_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class IDetailProductDatasource {
  Future<List<ProductImage>> getGallery();
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants();
  Future<List<ProductVariant>> getProductVariants();
}


class DetailProductRemoteDatasource extends IDetailProductDatasource{

  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery() async {
    try {
      Map<String,String> qParams = {'filter': 'product_id="0tc0e5ju89x5ogj"'};
      var response = await _dio.get('collections/gallery/records', queryParameters: qParams);
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
  
  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromMapJson(jsonObject))
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
  
  @override
  Future<List<Variant>> getVariants() async {
    try {
      Map<String,String> qParams = {'filter': 'product_id="0tc0e5ju89x5ogj"'};
      var response = await _dio.get('collections/variants/records', queryParameters: qParams);
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromMapJson(jsonObject))
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
  
  @override
  Future<List<ProductVariant>> getProductVariants() async {
     var variantTypeList = await getVariantTypes();
     var variantList = await getVariants();
     List<ProductVariant> productVariantList = [];
     for(var variantType in variantTypeList) {
      var variant = variantList.where((element) => element.typeId == variantType.id).toList();
      productVariantList.add(ProductVariant(variantType, variant));
     }
     return productVariantList;
  }
}