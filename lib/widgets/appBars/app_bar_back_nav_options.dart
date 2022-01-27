import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarBackNavOptions extends StatelessWidget{

  String title;
  List<Icon> listIcons;
  List<Function> listFunctions;
  
  AppBarBackNavOptions({
    required this.title,
    required this.listIcons,
    required this.listFunctions,
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
      actions: [
          IconButton(
              onPressed: () => {
                listFunctions[0]()
              }, 
              icon: listIcons[0]
            ),
            IconButton(
              onPressed: () => {
                listFunctions[1]()
              }, 
              icon: listIcons[1]
            )
      ]
    );
  }
}
  