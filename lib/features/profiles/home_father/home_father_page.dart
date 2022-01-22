
import 'dart:convert';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/profiles/home_father/home_father_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeFatherPage extends StatelessWidget {
  HomeFatherPage({Key? key}) : super(key: key);

  final controllerPage = Get.put(HomeFatherController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: homeFatherPageTitle,
        )
      ),
      drawer: Obx((){
        return HeaderFooterDrawerApp(
          user: controllerPage.usuarioLogged.value,
          listIcons: [Icon(Icons.home), Icon(Icons.list)],
          listNames: const [draweroptionsHome, drawerOptionAuthorizations],
          listFunctions: [() => {Navigator.pop(context)},() => {Get.offAndToNamed(AppLinks.LIST_ASSIGNS)}, ],
        );
      }),
      body: SafeArea(
          child: BackgroundColorSafe(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                TextAppNormal(text: homeFatherPageTextQr, color: textPrimaryColor),
                Container(
                  width: size.width,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        if(controllerPage.showQR == true){
                          return QrImage(
                            data: controllerPage.qrPrincipal.string,
                            version: QrVersions.auto,
                            size: 280
                          );
                        } if(controllerPage.showQRLoading == true) {
                          return CircularProgressIndicator();
                        } else {
                          return RoundedButton(
                            text: homeFatherPageGenerateQrButton,
                            color: primaryColor, 
                            press: () => { controllerPage.getQRPrincipal() } 
                          );
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                TextAppNormal(text: homeFatherPageChildren, color: textPrimaryColor),
                Obx(() {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: controllerPage.listChildren.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChildTile(
                        child: controllerPage.listChildren[index],
                      );
                    }
                  );
                })
              ]
            ),
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(Icons.add, size: 36),
          onPressed: () {
            Get.toNamed(AppLinks.NEW_ASSIGN);
          }
      ),
    );
  }
}