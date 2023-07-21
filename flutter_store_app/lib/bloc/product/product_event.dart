import 'package:flutter_store_app/data/model/product.dart';

abstract class ProductEvent{}

class ProductInitEvent extends ProductEvent{
  ProductInitEvent(this.productId,this.categoryId);
  String productId;
  String categoryId;
}

class ProductAddToBasket extends ProductEvent{
  ProductAddToBasket(this.product);
  Product product;
}