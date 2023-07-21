import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/card_item.dart';

abstract class BasketState{}


class BasketInitState extends BasketState{}


class BasketDataFetchedState extends BasketState{
  BasketDataFetchedState(this.basketItemList,this.basketFinalPrice);
  
  Either<String,List<BasketItem>> basketItemList;
  int basketFinalPrice;
}