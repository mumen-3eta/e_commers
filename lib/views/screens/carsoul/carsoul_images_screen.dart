import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commers/helper/constans.dart';
import 'package:e_commers/provider/firestore_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

class CarsoulImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: scafoldBackGround,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text('Carsoul Photos'.tr()),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: const Icon(Icons.add_rounded),
            onPressed: () {
              provider.uploadNewCarsoulImage();
            },
          ),
          body: Center(
            child: SizedBox(
              height: Get.height,
              width: Get.width * 0.9,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.photos.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          provider.deleteImageFromCarsoul(index);
                        },
                        child: CachedNetworkImage(
                          imageUrl: provider.photos[index].url,
                          imageBuilder: (context, imageProvider) => Container(
                            height: Get.height / 4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ),
        );
      },
    );
  }
}
