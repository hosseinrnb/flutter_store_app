import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/banner.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  HomeRequestSuccessState(this.bannerList);

  Either<String, List<MyBanner>> bannerList;
}
