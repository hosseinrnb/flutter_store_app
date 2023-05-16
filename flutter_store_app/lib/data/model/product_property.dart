class Property{
  Property(this.title, this.value);

  String title;
  String value;

  factory Property.fromMapJson(Map<String,dynamic> jsonObject) {
    return Property(
      jsonObject['title'],
      jsonObject['value'],
    );
  }
}