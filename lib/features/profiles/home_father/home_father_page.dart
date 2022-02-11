
import 'dart:convert';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/list_assigns/list_assign_controller.dart';
import 'package:clean_app/features/profiles/home_father/home_father_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/custom/assign_tile.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeFatherPage extends StatelessWidget {
  HomeFatherPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final controllerPage = Get.put(HomeFatherController());
    final controllerListAssign = Get.put(ListAssignController());

    var deviceData = MediaQuery.of(context);
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
          listFunctions: [
            () {controllerPage.currentPage.value = "HOMEPAGE"; controllerPage.reloadData();Navigator.pop(context);},
            () {controllerPage.currentPage.value = "LISTPAGE"; controllerListAssign.reloadData();Navigator.pop(context);}, 
          ],
          closeFunction: controllerPage.closeSession,
        );
      }),
      body: SafeArea(
          child: BackgroundColorSafe(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Obx(() {
                if(controllerPage.currentPage == "HOMEPAGE"){
                  return Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            return  ChildTile(
                                child: controllerPage.listChildren[index],
                            );
                          }
                        );
                      })
                    ]
                  );
                } else {
                  return Obx(() {
                    if(controllerListAssign.isLoading == true){
                      return SizedBox(
                        height: MediaQuery.of(context).size.height-60,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Obx(() {
                            return ListView.separated(
                              separatorBuilder: (context, index) => const Divider(
                                color: Colors.black,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(4),
                              itemCount: controllerListAssign.listAssign.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppLinks.DETAIL_ASSIGN, arguments: [json.encode(controllerListAssign.listAssign[index])]);
                                  },
                                  child: AssignTile(
                                    assign: controllerListAssign.listAssign[index],
                                  ),
                                );
                              }
                            );
                          }
                      );
                    }
                  });
                }
              }
            ),
          )
        )
      ),
      floatingActionButton: 
      Obx(() {
        if(controllerPage.currentPage == "HOMEPAGE"){
          return FloatingActionButton(
            heroTag: "btnHomeNew",
            backgroundColor: primaryColor,
            child: const Icon(Icons.add, size: 36),
            onPressed: () {
              Get.toNamed(AppLinks.NEW_ASSIGN);
            }
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "btnDetailSync",
                backgroundColor: primaryColor,
                child: const Icon(Icons.sync, size: 36),
                onPressed: () {
                  controllerListAssign.getListAssignByUser();
                }
              ),
              SizedBox(height: 10,),
              FloatingActionButton(
                heroTag: "btnDetailNew",
                backgroundColor: primaryColor,
                child: const Icon(Icons.add, size: 36),
                onPressed: () {
                  Get.toNamed(AppLinks.NEW_ASSIGN);
                }
              )
            ]
          );
        }
      }) 
    );
  }
}