import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/product/product_event.dart';
import 'package:flutter_store_app/bloc/product/product_state.dart';
import 'package:flutter_store_app/data/repository/product_detail_repository.dart';
import 'package:flutter_store_app/di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository _detailProductRepository = locator.get();

  ProductBloc() : super(ProductDetailInitState()) {
    on<ProductInitEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      var productImages = await _detailProductRepository.getProductImage(event.productId);
      var productVariants = await _detailProductRepository.getProductVariants(event.productId);
      var productCategory = await _detailProductRepository.getProductCategory(event.categoryId);
      var productProperties = await _detailProductRepository.getProductProperties(event.productId);

      emit(ProductDetailResponseState(productImages, productVariants, productCategory, productProperties));
    });
  }
}
