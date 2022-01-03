import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class AppBarDrawerTabApp extends StatelessWidget{

  String title;
  TabBar tabBar;
  
  AppBarDrawerTabApp({
    required this.title,
    required this.tabBar,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(title, style: const TextStyle(color: whiteColor, fontSize: textSizeNormalLabel),),
      leading: IconButton(
        onPressed: () => {
            Scaffold.of(context).openDrawer()
        }, 
        color: whiteColor,
        icon: const Icon(Icons.menu)
      ),
      bottom: PreferredSize(
        preferredSize: tabBar.preferredSize,
        child: ColoredBox(
          color: whiteColor,
          child: tabBar,
        )
      )
    );
  }
}
  