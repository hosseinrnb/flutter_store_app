class MyBanner {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? categoryId;

  MyBanner(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.categoryId,
  );

  factory MyBanner.fromMapJson(Map<String, dynamic> jsonObject) {
    return MyBanner(
      jsonObject['id'],
      jsonObject['collectionId'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['categoryId'],
    );
  }
}
