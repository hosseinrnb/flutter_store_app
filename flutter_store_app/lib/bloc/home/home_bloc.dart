import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/home/home_event.dart';
import 'package:flutter_store_app/bloc/home/home_state.dart';
import 'package:flutter_store_app/data/repository/banner_repository.dart';
import 'package:flutter_store_app/di/di.dart';


class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final IBannerRepository _bannerRepository = locator.get();
  HomeBloc():super(HomeInitState()) {
    on<HomeGetInitilizeData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanners();
      emit(HomeRequestSuccessState(bannerList));
    });
  }
}