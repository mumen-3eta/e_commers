import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:e_commers/provider/auth_provider.dart';
import 'package:e_commers/views/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

import '../../../helper/constans.dart';
import '../../widgets/defalut-big-Button.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 95 / Get.height,
                  ),
                  Form(
                    key: provider.signUpKey,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: backGroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sign Up'.tr(),
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: fontColor),
                              ),
                              const Spacer(),
                              InkWell(
                                child: Text(
                                  'Sign In'.tr(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor),
                                ),
                                onTap: () {
                                  NavHelper.navigateWithReplacementToWidget(
                                      SignInView());
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 10 / Get.height,
                          ),
                          SizedBox(
                            height: Get.height * 30 / Get.height,
                          ),
                          SizedBox(
                            height: Get.height * 30 / Get.height,
                          ),
                          Text(
                            'Email'.tr(),
                            //textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: fontColor.withOpacity(.5)),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: provider.emailController,
                            validator: provider.emailValidator,
                            decoration: const InputDecoration(
                              hintText: 'iamdavid@gmail.com',
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 30 / Get.height,
                          ),
                          Text(
                            'Password'.tr(),
                            //textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: fontColor.withOpacity(.5)),
                          ),
                          TextFormField(
                            controller: provider.passController,
                            validator: provider.passwordValidator,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'password'.tr(),
                            ),
                          ),
                          Row(
                            children: const [
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 20 / Get.height,
                          ),
                          DefultBigButton(
                            txt: 'SIGN UP'.tr(),
                            ontab: () {
                              provider.signUp();
                            },
                          ),
                          SizedBox(
                            height: Get.height * 20 / Get.height,
                          ),
                        ],
                      ),
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
