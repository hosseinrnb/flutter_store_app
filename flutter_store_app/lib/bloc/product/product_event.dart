abstract class ProductEvent{}

class ProductInitEvent extends ProductEvent{
  ProductInitEvent(this.productId);
  String productId;
}