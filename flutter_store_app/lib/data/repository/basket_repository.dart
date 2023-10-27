import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/basket_datasource.dart';
import 'package:flutter_store_app/data/model/card_item.dart';
import 'package:flutter_store_app/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
  Future<void> removeProduct(int index);
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasource datasource = locator.get();
  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      datasource.addProduct(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (ex) {
      return left('خطا در افزودن محصول به سبد خرید!');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemList = await datasource.getAllBasketItems();
      return right(basketItemList);
    } catch (ex) {
      return left('خطا در نمایش محصولات!');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return datasource.getBasketFinalPrice();
  }

  @override
  Future<void> removeProduct(int index) async {
    datasource.removeProduct(index);
  }
}
