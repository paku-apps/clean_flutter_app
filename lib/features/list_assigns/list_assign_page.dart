import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/list_assigns/list_assign_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/appBars/app_bar_options.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
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
        child: AppBarDrawerAppOption(
          title: listAssignsTitle,
          listIcons: [Icon(Icons.edit), Icon(Icons.delete)],
          listFunctions: [
            () {controllerListAssign.goToUpdateAssign();}, 
            () {
              showDialog(
                context: context, 
                builder: (_) => AlertDialog(
                  title: TextAppTitle(text: listAssignsEditTitle, color: textPrimaryColor),
                  content: TextAppNormal(text: listAssignsEditMessage,color: textPrimaryColor, noPaddingVertical: true,),
                  actions: [
                    TextButton(onPressed: () async {await controllerListAssign.deleteAssign();Navigator.pop(context);}, child: Text(listAssignsEditOk),),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: Text(listAssignsEditCancel),)
                  ],
                ),
                barrierDismissible: true,
              );
            }],
        )
      ),
      drawer: HeaderFooterDrawerApp(
        user: User(name: "Primero", lastName: "Segundo", email: "Correo"),
        listIcons: [Icon(Icons.home), Icon(Icons.list)],
        listNames: const [draweroptionsHome, drawerOptionAuthorizations],
        listFunctions: [() => {Get.offAndToNamed(AppLinks.HOME_FATHER)},() => {Navigator.pop(context)}, ],
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: Obx(() {
              if(controllerListAssign.isLoading == true){
                return CircularProgressIndicator();
              } else {
                return Center();
              }
            })
          )
        )
      )
    );
  }
}