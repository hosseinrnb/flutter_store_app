import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/category_product_datasource.dart';
import 'package:flutter_store_app/data/model/product.dart';
import 'package:flutter_store_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductByCategoryId(String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {

  final ICategoryProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductByCategoryId(String categoryId) async {
    try {
      var response = await _datasource.getProductByCategoryId(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }

}