import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commers/helper/constans.dart';
import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:e_commers/provider/auth_provider.dart';
import 'package:e_commers/provider/firestore_provider.dart';
import 'package:e_commers/views/screens/carsoul/carsoul_images_screen.dart';
import 'package:e_commers/views/screens/category_screens/add_category.dart';
import 'package:e_commers/views/widgets/category_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: scafoldBackGround,
            appBar: AppBar(
              title: Text('Home'.tr()),
              backgroundColor: primaryColor,
              automaticallyImplyLeading: false,
              actions: [
                InkWell(
                    onTap: () {
                      if (context.locale.toString() == 'en') {
                        context.setLocale(const Locale('ar'));
                      } else {
                        context.setLocale(const Locale('en'));
                      }
                    },
                    child: const Icon(Icons.language)),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut();
                    },
                    child: const Icon(Icons.logout))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavHelper.navigateToWidget(AddCategory());
              },
              backgroundColor: primaryColor,
              child: const Icon(Icons.add_rounded),
            ),
            body: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      NavHelper.navigateToWidget(CarsoulImages());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        items: provider.photos
                            .map((e) => CachedNetworkImage(
                                  imageUrl: e.url,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: Get.height / 4,
                                    width: Get.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Categories'.tr(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: Get.width * 0.9,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: provider.allCategories.length,
                          itemBuilder: ((context, index) {
                            return CategoryWidget(
                              category: provider.allCategories[index],
                            );
                          })),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
