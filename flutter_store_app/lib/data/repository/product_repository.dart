import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/product_datasource.dart';
import 'package:flutter_store_app/data/model/product.dart';
import 'package:flutter_store_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHottest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _datasource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHottest() async {
    try {
      var response = await _datasource.getHottest();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      var response = await _datasource.getBestSeller();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
}
