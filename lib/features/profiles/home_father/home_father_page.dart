
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/profiles/home_father/home_father_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFatherPage extends StatelessWidget {
  HomeFatherPage({Key? key}) : super(key: key);

  final controllerPage = Get.put(HomeFatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: homeFatherPageTitle,
        )
      ),
      drawer: HeaderFooterDrawerApp(user: User(name: "Primero", lastName: "Segundo", email: "Correo"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Profile Father'),
          Obx(() {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: controllerPage.listChildren.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('Entry ${controllerPage.listChildren[index].name}')),
                );
              }
            );
          })
        ]
      ),
    );
  }
}