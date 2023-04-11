import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/banner_datasource.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/di/di.dart';
import '../../util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<MyBanner>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<MyBanner>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
}
