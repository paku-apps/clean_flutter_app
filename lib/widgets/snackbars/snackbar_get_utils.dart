


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
    icon: Icon(Icons.check_circle_sharp, color: whiteColor),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: successfulSnackbar,
    borderRadius: 10,
    margin: EdgeInsets.all(8),
    snackStyle: SnackStyle.GROUNDED,
    colorText: whiteColor,
    duration: Duration(seconds: 3),
    isDismissible: false,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
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
    icon: Icon(Icons.cancel_outlined, color: whiteColor),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: errorSnackbar,
    snackStyle: SnackStyle.GROUNDED,
    borderRadius: 10,
    margin: EdgeInsets.all(8),
    colorText: whiteColor,
    duration: Duration(seconds: 3),
    isDismissible: false,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOutBack
  );
}