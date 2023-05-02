class VariantType {
  VariantType(
    this.id,
    this.name,
    this.title,
    this.type,
  );

  String id;
  String name;
  String title;
  VariantTypeEnum type;
  

  factory VariantType.fromMapJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.COLOR;
    case 'Storage':
      return VariantTypeEnum.STORAGE;
    case 'Voltage':
      return VariantTypeEnum.VOLTAGE;
    default:
    return VariantTypeEnum.COLOR;
  }
}


enum VariantTypeEnum {
  COLOR,
  STORAGE,
  VOLTAGE,
}
