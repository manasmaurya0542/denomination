import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String subTitle) {
  Get.snackbar(
    title,
    subTitle,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}