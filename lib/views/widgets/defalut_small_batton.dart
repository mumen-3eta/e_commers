import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constans.dart';

class SmallBattonWidget extends StatelessWidget {
  SmallBattonWidget({
    required this.name,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  String name;
  Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 812 * 50 / Get.height,
        width: 812 * 145 / Get.height,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
