import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarBackNav extends StatelessWidget{

  String title;
  
  AppBarBackNav({
    required this.title,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(title, style: const TextStyle(color: whiteColor, fontSize: textSizeNormalLabel),),
      leading: IconButton(
        onPressed: () => {
            Get.back()
        }, 
        color: whiteColor,
        icon: const Icon(Icons.arrow_back)
      ),
    );
  }
}
  