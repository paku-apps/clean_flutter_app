import 'dart:convert';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/list_assigns/list_assign_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/appBars/app_bar_options.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/custom/assign_tile.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:clean_app/widgets/texts/text_app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAssignPage extends StatelessWidget {
  const ListAssignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final controllerListAssign = Get.put(ListAssignController());
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: listAssignsTitle,
        )
      ),
      drawer: Obx((){ 
        return HeaderFooterDrawerApp(
          user: controllerListAssign.usuarioLogged.value,
          listIcons: [Icon(Icons.home), Icon(Icons.list)],
          listNames: const [draweroptionsHome, drawerOptionAuthorizations],
          listFunctions: [() => {Get.offAndToNamed(AppLinks.HOME_FATHER)},() => {Navigator.pop(context)}, ],
          closeFunction: controllerListAssign.closeSession,
        );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(Icons.sync, size: 36),
          onPressed: () {
            controllerListAssign.getListAssignByUser();
          }
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: Obx(() {
              if(controllerListAssign.isLoading == true){
                return SizedBox(
                  height: MediaQuery.of(context).size.height-60,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Obx(() {
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
                    })
                  ],
                );
              }
            })
          )
        )
      )
    );
  }
}