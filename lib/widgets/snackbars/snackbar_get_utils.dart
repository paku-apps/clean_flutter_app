


import 'package:clean_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackbar(
  String title, 
  String message
){
  Get.snackbar(
    title, 
    message,
    icon: const Icon(Icons.check_circle_sharp, color: whiteColor),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: successfulSnackbar,
    borderRadius: 10,
    margin: const EdgeInsets.all(8),
    snackStyle: SnackStyle.GROUNDED,
    colorText: whiteColor,
    duration: const Duration(seconds: 3),
    isDismissible: false,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack
  );
}

void showErrorSnackbar(
  String title, 
  String message
){
  Get.snackbar(
    title, 
    message,
    icon: const Icon(Icons.cancel_outlined, color: whiteColor),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: errorSnackbar,
    snackStyle: SnackStyle.GROUNDED,
    borderRadius: 10,
    margin: const EdgeInsets.all(8),
    colorText: whiteColor,
    duration: const Duration(seconds: 3),
    isDismissible: false,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack
  );
}