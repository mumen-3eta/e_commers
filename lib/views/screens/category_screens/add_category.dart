// ignore_for_file: use_build_context_synchronously

import 'package:e_commers/custom_dialog/custom_dialog.dart';
import 'package:e_commers/helper/constans.dart';
import 'package:e_commers/provider/firestore_provider.dart';
import 'package:e_commers/views/widgets/defalut-big-Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            provider.resetCategory();
            return true;
          },
          child: Form(
            key: provider.categoryKey,
            child: Scaffold(
              backgroundColor: scafoldBackGround,
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text('Add New Catgory'.tr()),
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
                          ? Container(
                              height: Get.height / 3,
                              width: Get.height / 3,
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: backGroundColor,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(4)),
                              child: InkWell(
                                  onTap: () {
                                    provider.selectImage();
                                  },
                                  child: const Icon(Icons.add)),
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
                        'Category name in Arabic'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.categoryNameArController,
                        validator: provider.nullValidation,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      Text(
                        'Category name in English'.tr(),
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: fontColor.withOpacity(.5)),
                      ),
                      TextFormField(
                        controller: provider.categoryNameEnController,
                        validator: provider.nullValidation,
                      ),
                      SizedBox(
                        height: Get.height * 30 / Get.height,
                      ),
                      DefultBigButton(
                          ontab: (() async {
                            if (provider.selectedImage == null) {
                              CustomDialog.showDialogFunction(
                                  'Image Reqiured'.tr(),
                                  'please select image for category'.tr());
                              return;
                            }
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
                            await provider.addNewCategory();
                            Navigator.of(dialogContext).pop();
                            Navigator.of(context).pop();
                          }),
                          txt: 'Add new Category'.tr())
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
