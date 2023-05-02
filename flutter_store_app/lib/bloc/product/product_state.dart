import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/data/model/product_variant.dart';
import 'package:flutter_store_app/data/model/variant_type.dart';

abstract class ProductState {}

class ProductDetailInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  ProductDetailResponseState(
    this.productImages,
    this.productVariants,
  );

  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariants;
}
