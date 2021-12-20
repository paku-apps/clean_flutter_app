import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:clean_app/widgets/texts/text_app_title.dart';
import 'package:flutter/material.dart';

class HeaderFooterDrawerApp extends StatelessWidget {

  User user;
  
  HeaderFooterDrawerApp({
    Key? key,
    required this.user,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    TextAppNormal(text: user.email, color: whiteColor)
                  ],
                ),
              )
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }



}
  