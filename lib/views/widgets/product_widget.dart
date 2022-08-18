import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commers/helper/constans.dart';
import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:e_commers/models/product_model.dart';
import 'package:e_commers/provider/firestore_provider.dart';
import 'package:e_commers/views/screens/product/edit_product.dart';
import 'package:e_commers/views/screens/product/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

class ProductWidget extends StatelessWidget {
  String catId;
  ProductModel product;
  ProductWidget({required this.product, required this.catId});
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            provider.productNameArController.text = product.nameAr;
            provider.productNameEnController.text = product.nameEn;
            provider.productDescriptionArController.text =
                product.descriptionAr;
            provider.productDescriptionEnController.text =
                product.descriptionEn;
            provider.productPriceController.text = product.price.toString();
            provider.productQuantityController.text =
                product.quantity.toString();
            NavHelper.navigateToWidget(
                ViewProduct(product: product, catId: catId));
          },
          child: Container(
            height: Get.height / 3.5,
            width: Get.width * 0.9,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: backGroundColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              CachedNetworkImage(
                imageUrl: product.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: Get.height / 5,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Text(
                        context.locale.toString() == 'en'
                            ? product.nameEn
                            : product.nameAr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5))),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.productNameArController.text = product.nameAr;
                        provider.productNameEnController.text = product.nameEn;
                        provider.productDescriptionArController.text =
                            product.descriptionAr;
                        provider.productDescriptionEnController.text =
                            product.descriptionEn;
                        provider.productPriceController.text =
                            product.price.toString();
                        provider.productQuantityController.text =
                            product.quantity.toString();
                        NavHelper.navigateToWidget(
                            EditProduct(product: product, catId: catId));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: Text('Edit'.tr()),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.deleteProduct(product, catId);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text('Delete'.tr()),
                    ),
                  )
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
