import 'package:e_commers/helper/nav/nav_helper.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static showDialogFunction(String title, String content) {
    showDialog(
        context: NavHelper.navkey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    NavHelper.popRouter();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
