class ImageModel {
  late String id;
  late String url;

  ImageModel({required this.url});

  ImageModel.fromMap(Map<String, dynamic> map) {
    url = map['url'];
  }

  toMap() {
    return {'url': url};
  }
}
