
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/profiles/home_father/home_father_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      drawer: HeaderFooterDrawerApp(user: User(name: "Primero", lastName: "Segundo", email: "Correo"),),
      body: Column(
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
                    return Text("Mostrar QR TRUE");
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