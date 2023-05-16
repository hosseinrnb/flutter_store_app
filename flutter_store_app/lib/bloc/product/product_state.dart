import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/category.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/data/model/product_property.dart';
import 'package:flutter_store_app/data/model/product_variant.dart';
import 'package:flutter_store_app/data/model/variant_type.dart';

abstract class ProductState {}

class ProductDetailInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  ProductDetailResponseState(
    this.productImages,
    this.productVariants,
    this.productCategory,
    this.productProperties
  );

  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariants;
  Either<String, Category> productCategory;
  Either<String, List<Property>> productProperties;
}
