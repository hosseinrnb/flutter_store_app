import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/data/model/category.dart';
import 'package:flutter_store_app/data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  HomeRequestSuccessState(this.bannerList, this.categoryList, this.productList,
      this.hottestProductList, this.bestSellerProductList);

  Either<String, List<MyBanner>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hottestProductList;
  Either<String, List<Product>> bestSellerProductList;
}
