import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/product.dart';

abstract class CategoryProductState{}

class CategoryProductLoadingState extends CategoryProductState{}

class CategoryProductResponseSuccessState extends CategoryProductState{
  CategoryProductResponseSuccessState(this.ProductListByCategory);

  Either<String, List<Product>> ProductListByCategory;
}
