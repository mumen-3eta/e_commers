import 'dart:io';

import 'package:e_commers/helper/constans.dart';
import 'package:e_commers/helper/firestore_helper.dart';
import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:e_commers/helper/storage_helper.dart';
import 'package:e_commers/models/category_model.dart';
import 'package:e_commers/models/image_model.dart';
import 'package:e_commers/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreProvider extends ChangeNotifier {
  GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
  TextEditingController categoryNameArController = TextEditingController();
  TextEditingController categoryNameEnController = TextEditingController();
  File? selectedImage;
  String? selectedImageUrl;
  List<CategoryModel> allCategories = [];
  static late SharedPreferences prefs;

  FirestoreProvider() {
    getAllCategories();
    getAllImages();
  }

  selectImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xfile!.path);
    notifyListeners();
  }

  String? nullValidation(String? v) {
    if (v == null || v.isEmpty) {
      return 'this field is required';
    }
    return null;
  }

  resetCategory() {
    selectedImage = null;
    selectedImageUrl = null;
    categoryNameArController.clear();
    categoryNameEnController.clear();
  }

  addNewCategory() async {
    if (categoryKey.currentState!.validate()) {
      String imageUrl =
          await Storagehelper.storagehelper.uploadImage(selectedImage!);
      CategoryModel category = CategoryModel(
          nameAr: categoryNameArController.text,
          nameEn: categoryNameEnController.text,
          imageUrl: imageUrl);
      CategoryModel newCategory =
          await FirestoreHelper.firestoreHelper.addNewCategory(category);
      allCategories.add(newCategory);
      resetCategory();
      notifyListeners();
    }
  }

  getAllCategories() async {
    allCategories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  updateCategory(CategoryModel category) async {
    String? imageUrl;
    if (categoryKey.currentState!.validate()) {
      if (selectedImage != null) {
        imageUrl =
            await Storagehelper.storagehelper.uploadImage(selectedImage!);
      }
      CategoryModel newCategory = CategoryModel(
          nameAr: categoryNameArController.text,
          nameEn: categoryNameEnController.text,
          imageUrl: imageUrl ?? category.imageUrl);
      newCategory.catId = category.catId;
      await FirestoreHelper.firestoreHelper.updateCategory(newCategory);
      int index = allCategories.indexOf(allCategories
          .where((element) => element.catId == category.catId)
          .first);
      allCategories[index] = newCategory;
      resetCategory();
      notifyListeners();
    }
  }

  deleteCategory(CategoryModel category) async {
    await FirestoreHelper.firestoreHelper.deleteCategory(category);
    allCategories.removeWhere((element) => element.catId == category.catId);
    notifyListeners();
  }

  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  TextEditingController productNameArController = TextEditingController();
  TextEditingController productNameEnController = TextEditingController();
  TextEditingController productDescriptionArController =
      TextEditingController();
  TextEditingController productDescriptionEnController =
      TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  List<ProductModel> products = [];

  resetProduct() {
    selectedImage = null;
    selectedImageUrl = null;
    products.clear();
    productNameArController.clear();
    productNameEnController.clear();
    productDescriptionArController.clear();
    productDescriptionEnController.clear();
    productPriceController.clear();
    productQuantityController.clear();
  }

  resetProductWithoutList() {
    selectedImage = null;
    selectedImageUrl = null;
    productNameArController.clear();
    productNameEnController.clear();
    productDescriptionArController.clear();
    productDescriptionEnController.clear();
    productPriceController.clear();
    productQuantityController.clear();
  }

  getAllProducts(String catId) async {
    products = await FirestoreHelper.firestoreHelper.getAllProducts(catId);
    notifyListeners();
  }

  addNewProduct(String catId) async {
    if (productKey.currentState!.validate()) {
      String imageUrl =
          await Storagehelper.storagehelper.uploadImage(selectedImage!);
      ProductModel product = ProductModel(
          nameAr: productNameArController.text,
          nameEn: productNameEnController.text,
          descriptionAr: productDescriptionArController.text,
          descriptionEn: productDescriptionEnController.text,
          imageUrl: imageUrl,
          price: num.parse(productPriceController.text),
          quantity: int.parse(productQuantityController.text));
      ProductModel newProduct =
          await FirestoreHelper.firestoreHelper.addNewProduct(product, catId);
      products.add(newProduct);
      resetProductWithoutList();
      notifyListeners();
    }
  }

  updateProduct(ProductModel product, String catId) async {
    String? imageUrl;
    if (productKey.currentState!.validate()) {
      if (selectedImage != null) {
        imageUrl =
            await Storagehelper.storagehelper.uploadImage(selectedImage!);
      }
      ProductModel newProduct = ProductModel(
          nameAr: productNameArController.text,
          nameEn: productNameEnController.text,
          descriptionAr: productDescriptionArController.text,
          descriptionEn: productDescriptionEnController.text,
          imageUrl: imageUrl ?? product.imageUrl,
          price: num.parse(productPriceController.text),
          quantity: int.parse(productQuantityController.text));
      newProduct.id = product.id;
      await FirestoreHelper.firestoreHelper.updateProduct(newProduct, catId);
      int index = products
          .indexOf(products.where((element) => element.id == product.id).first);
      products[index] = newProduct;
      resetProductWithoutList();
      notifyListeners();
    }
  }

  deleteProduct(ProductModel product, String catId) async {
    await FirestoreHelper.firestoreHelper.deleteProduct(product, catId);
    products.removeWhere((element) => element.id == product.id);
    resetProductWithoutList();
    notifyListeners();
  }

  List<ImageModel> photos = [];

  uploadNewCarsoulImage() async {
    String? imageUrl;
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      late BuildContext dialogContext;
      showDialog(
        context: NavHelper.navkey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            child: SizedBox(
              height: Get.height / 7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Loading"),
                  ],
                ),
              ),
            ),
          );
        },
      );
      File file = File(xfile.path);
      imageUrl = await Storagehelper.storagehelper.uploadImage(file);
      ImageModel image = ImageModel(url: imageUrl);
      await FirestoreHelper.firestoreHelper.addNewImage(image);
      photos.add(image);
      notifyListeners();
      Navigator.of(dialogContext).pop();
    }
  }

  getAllImages() async {
    photos = await FirestoreHelper.firestoreHelper.getAllImages();
    notifyListeners();
  }

  deleteImageFromCarsoul(int index) {
    FirestoreHelper.firestoreHelper.deleteImage(photos[index]);
    photos.removeAt(index);
    notifyListeners();
  }
}
