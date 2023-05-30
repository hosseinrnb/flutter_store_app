abstract class CategoryProductEvent{}

class CategoryProductInit extends CategoryProductEvent{
  CategoryProductInit(this.categoryId);

  String categoryId;
}