import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/list_assigns/list_assign_controller.dart';
import 'package:clean_app/features/profiles/home_charge/home_charge_controller.dart';
import 'package:clean_app/features/profiles/home_father/home_father_controller.dart';
import 'package:clean_app/features/profiles/home_supervisor/home_supervisor_controller.dart';
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
  Function closeFunction;
  
  HeaderFooterDrawerApp({
    Key? key,
    required this.user,
    required this.listIcons,
    required this.listNames,
    required this.listFunctions,
    required this.closeFunction
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    int sizeElements = listIcons.length;

    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 220,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarCircleInitials(firstName: user.nombres, lastName: user.apellidoPaterno),
                    TextAppTitle(text: user.nombres+ emptySpace +user.apellidoPaterno, color: whiteColor),
                    TextAppNormal(text: user.correo, color: whiteColor, noPaddingVertical: true)
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
              onTap: () async {
                closeFunction();
                Get.delete<HomeFatherController>();
                Get.delete<HomeChargeController>();
                Get.delete<ListAssignController>();
                Get.delete<HomeSupervisorController>();
                //Get.offAllNamed(AppLinks.LOGIN);
              },
            )
          ],
        ),
    );
  }



}
  