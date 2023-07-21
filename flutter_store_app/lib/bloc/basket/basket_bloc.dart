import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/basket/basket_event.dart';
import 'package:flutter_store_app/bloc/basket/basket_state.dart';
import 'package:flutter_store_app/util/payment_handler.dart';
import '../../data/repository/basket_repository.dart';


class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository;
  final PaymentHandler _paymentHandler;

  BasketBloc(this._paymentHandler, this._basketRepository) : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      var finalPrice = await _basketRepository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemList, finalPrice));
    });

    on<BasketPaymentInitEvent>((event, emit) async {
      _paymentHandler.initPaymentRequest();
    });

    on<BasketPaymentRequestEvent>((event, emit) {
      _paymentHandler.sendPaymentRequest();
    });
  }
}
