import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/product_detail_datasource.dart';
import 'package:flutter_store_app/data/model/category.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/data/model/product_property.dart';
import 'package:flutter_store_app/data/model/product_variant.dart';
import 'package:flutter_store_app/data/model/variant_type.dart';
import 'package:flutter_store_app/di/di.dart';
import '../../util/api_exception.dart';


abstract class IDetailProductRepository{
  Future<Either<String,List<ProductImage>>> getProductImage(String productId);
  Future<Either<String,List<VariantType>>> getVatiantTypes();
  Future<Either<String,List<ProductVariant>>> getProductVariants(String productId);
  Future<Either<String,Category>> getProductCategory(String categoryId);
  Future<Either<String,List<Property>>> getProductProperties(String productId);
}

class DetailProductRepository extends IDetailProductRepository{

  final IDetailProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImage(String productId) async {
    try {
      var response = await _datasource.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
  
  @override
  Future<Either<String, List<VariantType>>> getVatiantTypes() async {
    try {
      var response = await _datasource.getVariantTypes();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
  
  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(String productId) async {
    try {
      var response = await _datasource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
  
  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var response = await _datasource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
  
  @override
  Future<Either<String, List<Property>>> getProductProperties(String productId) async {
    try {
      var response = await _datasource.getProductProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }

}