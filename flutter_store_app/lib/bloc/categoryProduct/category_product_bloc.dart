import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_store_app/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_store_app/data/repository/category_product_repository.dart';
import 'package:flutter_store_app/di/di.dart';

class CategoryProductBloc extends Bloc<CategoryProductEvent,CategoryProductState> {

  final ICategoryProductRepository _repository = locator.get();

  CategoryProductBloc():super(CategoryProductLoadingState()) {
    on<CategoryProductInit>((event, emit) async {
      var response = await _repository.getProductByCategoryId(event.categoryId);
      emit(CategoryProductResponseSuccessState(response));
    });
  }
}