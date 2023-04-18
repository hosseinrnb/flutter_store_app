import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/product_image.dart';

abstract class ProductState {}

class ProductDetailInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  ProductDetailResponseState(this.getProductImage);
  Either<String, List<ProductImage>> getProductImage;
}
