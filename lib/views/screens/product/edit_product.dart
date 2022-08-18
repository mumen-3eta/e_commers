// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commers/custom_dialog/custom_dialog.dart';
import 'package:e_commers/helper/constans.dart';
import 'package:e_commers/models/product_model.dart';
import 'package:e_commers/provider/firestore_provider.dart';
import 'package:e_commers/views/widgets/defalut-big-Button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';

class EditProduct extends StatelessWidget {
  ProductModel product;
  String catId;
  EditProduct({required this.product, required this.catId});
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            provider.resetProductWithoutList();
            return true;
          },
          child: Form(
            key: provider.productKey,
            child: Scaffold(
              backgroundColor: scafoldBackGround,
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text('Edit Product'.tr()),
              ),
              body: Center(
                child: SingleChildScrollView(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      provider.selectedImage == null
                          ? CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              fit: BoxFit.cover,
                              height: Get.height / 3,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : InkWell(
                              onTap: () {
                                provider.selectImage();
                              },
                              child: Image.file(
                                provider.selectedImage!,
                                fit: BoxFit.cover,
                                height: Get.height / 3,
                              ),
                            ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Product name in Arabic'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.productNameArController,
                        validator: provider.nullValidation,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Product name in English'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.productNameEnController,
                        validator: provider.nullValidation,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Product description in Arabic'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.productDescriptionArController,
                        validator: provider.nullValidation,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Product description in English'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.productDescriptionEnController,
                        validator: provider.nullValidation,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Product price'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.productPriceController,
                        validator: provider.nullValidation,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Product quantity'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.productQuantityController,
                        validator: provider.nullValidation,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      DefultBigButton(
                          ontab: (() async {
                            late BuildContext dialogContext;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                dialogContext = context;
                                return Dialog(
                                  child: SizedBox(
                                    height: Get.height / 7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          const CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text('Loading'.tr()),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                            await provider.updateProduct(product, catId);
                            Navigator.of(dialogContext).pop();
                            Navigator.of(context).pop();
                          }),
                          txt: 'Update Product'.tr())
                    ],
                  ),
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}
