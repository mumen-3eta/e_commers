import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/models/category_model.dart';
import 'package:e_commers/models/image_model.dart';
import 'package:e_commers/models/product_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  CollectionReference<Map<String, dynamic>> categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  CollectionReference<Map<String, dynamic>> imagesCollection =
      FirebaseFirestore.instance.collection('images');

  Future<CategoryModel> addNewCategory(CategoryModel category) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await categoryCollection.add(category.toMap());
    category.catId = documentReference.id;
    return category;
  }

  Future<List<CategoryModel>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await categoryCollection.get();
    return querySnapshot.docs.map((e) {
      CategoryModel category = CategoryModel.fromMap(e.data());
      category.catId = e.id;
      return category;
    }).toList();
  }

  deleteCategory(CategoryModel category) async {
    await categoryCollection.doc(category.catId).delete();
  }

  updateCategory(CategoryModel category) async {
    await categoryCollection.doc(category.catId).update(category.toMap());
  }

  Future<ProductModel> addNewProduct(ProductModel product, String catId) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(catId)
            .collection('products')
            .add(product.toMap());
    product.id = documentReference.id;
    return product;
  }

  Future<List<ProductModel>> getAllProducts(String catId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('categories')
        .doc(catId)
        .collection('products')
        .get();
    return querySnapshot.docs.map((e) {
      ProductModel product = ProductModel.fromMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
  }

  updateProduct(ProductModel product, String catId) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(catId)
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }

  deleteProduct(ProductModel product, String catId) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(catId)
        .collection('products')
        .doc(product.id)
        .delete();
  }

  Future<ImageModel> addNewImage(ImageModel image) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await imagesCollection.add(image.toMap());
    image.id = documentReference.id;
    return image;
  }

  Future<List<ImageModel>> getAllImages() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await imagesCollection.get();
    return querySnapshot.docs.map((e) {
      ImageModel image = ImageModel.fromMap(e.data());
      image.id = e.id;
      return image;
    }).toList();
  }

  deleteImage(ImageModel image) async {
    await imagesCollection.doc(image.id).delete();
  }
}
