abstract class ProductEvent{}

class ProductInitEvent extends ProductEvent{
  ProductInitEvent(this.productId,this.categoryId);
  String productId;
  String categoryId;
}