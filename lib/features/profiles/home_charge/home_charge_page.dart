
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/profiles/home_charge/home_charge_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer_tab.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChargePage extends StatelessWidget {
  const HomeChargePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeChargeController>(
      init: HomeChargeController(),
      builder: (homeChargeController) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), 
          child: DefaultTabController(
            length: homeChargeController.tabCharger.length,
            child: AppBarDrawerTabApp(
              title: homeChargerPageTitle,
              tabBar: TabBar(
                controller: homeChargeController.tabBarcontroller,
                unselectedLabelColor: Colors.grey,
                labelColor: primaryColor,
                indicatorWeight: 5,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.indigo,
                tabs: const [
                  Tab(text: 'Hoy'),
                  Tab(text: 'Programaciones')
                ],
                automaticIndicatorColorAdjustment: true,
              ),
            )
          )
        ),
        drawer: HeaderFooterDrawerApp(
          user: User(),
          listIcons: [Icon(Icons.home)],
          listNames: const [draweroptionsHome],
          listFunctions: [() => {Navigator.pop(context)}],
          closeFunction: homeChargeController.closeSession,
        ),
        body: TabBarView(
          controller: homeChargeController.tabBarcontroller,
          children: [
            //Hoy programacion
            SafeArea(
              child: BackgroundColorSafe(
                colorBackground: colorBackgroundWhite,
                child: Obx(() {
                  if(homeChargeController.listChildrenToday.isEmpty){
                    return EmptyStateApp(
                            pathImage: "assets/images/box.png", 
                            messageEmpty: "No se encontraron autorizaciones para hoy", 
                            colorState: Colors.black
                    );
                  } else {
                    return Column(
                      children: [
                          ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: homeChargeController.listChildrenToday.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChildTile(
                              child: homeChargeController.listChildrenToday[index],
                            );
                          }
                        ),
                        RoundedButton(text: homeChargerPageButtonQR, press: () {})
                      ]
                    );
                  }
                })
              )
            ),
            //Programaciones
            SafeArea(
              child: BackgroundColorSafe(
                colorBackground: colorBackgroundWhite,
                child: Obx(() {
                  if(homeChargeController.listChildrenProgram.isEmpty){
                    return EmptyStateApp(
                            pathImage: "assets/images/box.png", 
                            messageEmpty: "No se encontraron autorizaciones programadas", 
                            colorState: Colors.black
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: homeChargeController.listChildrenProgram.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChildTile(
                          child: homeChargeController.listChildrenProgram[index],
                        );
                      }
                    );
                  }
                })
              )
            ),
          ]
        )
      )
    );     
  }
}