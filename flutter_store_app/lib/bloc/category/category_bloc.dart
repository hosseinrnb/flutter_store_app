import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/category/category_event.dart';
import 'package:flutter_store_app/bloc/category/category_state.dart';
import 'package:flutter_store_app/data/repository/category_repository.dart';
import 'package:flutter_store_app/di/di.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{

  final ICategoryRepository _repository = locator.get();

  CategoryBloc():super(CategoryInitState()){
    on((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}