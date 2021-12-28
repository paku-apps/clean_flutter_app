import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class AppBarDrawerAppOption extends StatelessWidget{

  String title;
  List<Icon> listIcons;
  List<Function> listFunctions;
  
  AppBarDrawerAppOption({
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
            Scaffold.of(context).openDrawer()
        }, 
        color: whiteColor,
        icon: const Icon(Icons.menu)
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
        /*
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: listIcons.length,
          itemBuilder: (BuildContext context, int index) {
            return IconButton(
              onPressed: () => {
                listFunctions[index]()
              }, 
              icon: listIcons[index]
            );
          }
        )*/
      ],
    );
  }
}
  