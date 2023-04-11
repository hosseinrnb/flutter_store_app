import 'package:dio/dio.dart';
import 'package:flutter_store_app/data/datasource/authentication_datasource.dart';
import 'package:flutter_store_app/data/datasource/banner_datasource.dart';
import 'package:flutter_store_app/data/datasource/category_datasource.dart';
import 'package:flutter_store_app/data/repository/authentication_repository.dart';
import 'package:flutter_store_app/data/repository/banner_repository.dart';
import 'package:flutter_store_app/data/repository/category_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;


Future<void> getItInit() async {
  
  //components
  locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));
  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());


  //datasources
  locator.registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator.registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());


  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());

}