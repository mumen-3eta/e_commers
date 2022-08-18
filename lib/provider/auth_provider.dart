import 'package:e_commers/helper/auth_helper.dart';
import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:e_commers/views/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  nullValidation(String? v) {
    if (v == null || v.isEmpty) {
      return 'this field is required';
    }
  }

  String? emailValidator(String? value) {
    if (value == null) {
      return 'email is required';
    } else if (!isEmail(value)) {
      return 'invalied email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null) {
      return 'password is required';
    } else if (value.length < 6) {
      return 'password must be 6 charactars or more';
    }
    return null;
  }

  resetUser() {
    emailController.clear();
    passController.clear();
  }

  signIn() async {
    if (loginKey.currentState!.validate()) {
      UserCredential? credential = await AuthHelper.authHelper
          .signIn(emailController.text, passController.text);
      if (credential != null) {
        resetUser();
        NavHelper.navigateWithReplacementToWidget(const HomeScreen());
      }
    }
  }

  signUp() async {
    if (signUpKey.currentState!.validate()) {
      UserCredential? credential = await AuthHelper.authHelper
          .signUp(emailController.text, passController.text);
      if (credential != null) {
        resetUser();
        NavHelper.navigateWithReplacementToWidget(const HomeScreen());
      }
    }
  }

  checkUser() {
    AuthHelper.authHelper.checkUser();
  }

  forgetPassword() {
    AuthHelper.authHelper.forgetPassword('mumen.3eta@gmail.com');
  }

  signOut() {
    AuthHelper.authHelper.signOut();
  }
}
