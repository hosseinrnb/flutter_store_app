import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/data/model/category.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  HomeRequestSuccessState(this.bannerList, this.categoryList);

  Either<String, List<MyBanner>> bannerList;
  Either<String, List<Category>> categoryList;
}
