import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:clean_app/widgets/texts/text_app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderFooterDrawerApp extends StatelessWidget {

  User user;
  List<Icon> listIcons;
  List<String> listNames;
  List<Function> listFunctions;
  
  HeaderFooterDrawerApp({
    Key? key,
    required this.user,
    required this.listIcons,
    required this.listNames,
    required this.listFunctions
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    int sizeElements = this.listIcons.length;

    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarCircleInitials(firstName: user.name, lastName: user.lastName),
                    TextAppTitle(text: user.name+ emptySpace +user.lastName, color: whiteColor),
                    TextAppNormal(text: user.email, color: whiteColor, noPaddingVertical: true)
                  ],
                ),
              )
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: sizeElements,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: listIcons[index],
                  title: Text(listNames[index]),
                  onTap: () {
                    listFunctions[index]();
                  },
                );
              }
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(closeSession),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
    );
  }



}
  