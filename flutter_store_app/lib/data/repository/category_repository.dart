import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/category_datasource.dart';
import 'package:flutter_store_app/data/model/category.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/util/api_exception.dart';

abstract class ICategoryRepository{
  Future<Either<String,List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository{

  final ICategoryDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }

}