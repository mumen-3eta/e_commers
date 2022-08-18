import 'package:e_commers/custom_dialog/custom_dialog.dart';
import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:e_commers/views/screens/auth/auth_screen.dart';
import 'package:e_commers/views/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.showDialogFunction(
            'User ot found', 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        CustomDialog.showDialogFunction(
            'Wrong password', 'Wrong password provided for that user');
      }
    }
    return null;
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.showDialogFunction(
            'Weak password', 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.showDialogFunction('Email already in use',
            'The account already exists for that email');
      }
    }
    return null;
  }

  checkUser() async {
    User? user = firebaseAuth.currentUser;
    if (user == null) {
      NavHelper.navigateWithReplacementToWidget(SignInView());
    } else {
      NavHelper.navigateWithReplacementToWidget(const HomeScreen());
    }
  }

  signOut() async {
    firebaseAuth.signOut();
    NavHelper.navigateWithReplacementToWidget(SignInView());
  }

  forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustomDialog.showDialogFunction(
          'Email sent', 'please go to email to change password');
    } on Exception {
      //
    }
  }
}
