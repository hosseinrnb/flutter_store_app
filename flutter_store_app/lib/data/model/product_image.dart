class ProductImage{
  ProductImage(this.imageUrl,this.productID);

  String imageUrl;
  String productID;


  factory ProductImage.fromMapJson(Map<String,dynamic> jsonObject) {

    return ProductImage(
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );

  }

}