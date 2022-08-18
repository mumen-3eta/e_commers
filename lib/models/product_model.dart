class ProductModel {
  late String id;
  late String nameAr;
  late String nameEn;
  late String descriptionAr;
  late String descriptionEn;
  late String imageUrl;
  late num price;
  late int quantity;

  ProductModel(
      {required this.nameAr,
      required this.nameEn,
      required this.descriptionAr,
      required this.descriptionEn,
      required this.imageUrl,
      required this.price,
      required this.quantity});

  ProductModel.fromMap(Map<String, dynamic> map) {
    nameAr = map['nameAr'];
    nameEn = map['nameEn'];
    descriptionAr = map['descriptionAr'];
    descriptionEn = map['descriptionEn'];
    imageUrl = map['imageUrl'];
    price = map['price'];
    quantity = map['quantity'];
  }

  toMap() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity
    };
  }
}
