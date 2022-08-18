class CategoryModel {
  late String catId;
  late String nameAr;
  late String nameEn;
  late String imageUrl;
  CategoryModel(
      {required this.nameAr, required this.nameEn, required this.imageUrl});

  CategoryModel.fromMap(Map<String, dynamic> map) {
    nameAr = map['nameAr'];
    nameEn = map['nameEn'];
    imageUrl = map['imageUrl'];
  }

  toMap() {
    return {'nameAr': nameAr, 'nameEn': nameEn, 'imageUrl': imageUrl};
  }
}
