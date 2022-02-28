
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/profiles/home_charge/home_charge_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer_tab.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/custom/assign_children_tile.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChargePage extends StatelessWidget {
  const HomeChargePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controllerPage = Get.put(HomeChargeController());

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
                isScrollable: isMobile() ? false : true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.indigo,
                tabs: [
                  Container(
                    width: isMobile() ? size.width * 0.5 : size.width*0.4,
                    child: Tab(text: 'Hoy'),
                  ),
                  Container(
                    width: isMobile() ? size.width * 0.5 : size.width*0.4,
                    child: Tab(text: 'Futuras')
                  )
                  ],
                onTap: (value) {
                  if(value == 0){
                    homeChargeController.getauthorizationsForToday();
                  }
                  if(value == 1){
                    homeChargeController.getauthorizationsForFuture();
                  }
                },
                
                automaticIndicatorColorAdjustment: true,
              ),
            )
          )
        ),
        drawer: HeaderFooterDrawerApp(
          user: homeChargeController.usuarioLogged.value,
          listIcons: [Icon(Icons.home)],
          listNames: const [draweroptionsHome],
          listFunctions: [() => {Navigator.pop(context)}],
          closeFunction: homeChargeController.closeSession,
        ),
        body: TabBarView(
          controller: homeChargeController.tabBarcontroller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            //Hoy programacion
            SafeArea(
              child: BackgroundColorSafe(
                colorBackground: colorBackgroundWhite,
                  child: Obx(() {
                    if(homeChargeController.loadingToday.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(homeChargeController.listAssignChildrenToday.isEmpty){
                      return EmptyStateApp(
                              pathImage: "assets/images/box.png", 
                              messageEmpty: "No se encontraron autorizaciones para hoy", 
                              colorState: Colors.black
                      );
                    } else { return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              RoundedButton(text: homeChargerPageButtonQR, press: () {
                                Get.toNamed(AppLinks.CHARGER_QR);
                              }),
                              ListView.builder(
                                primary: false,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: homeChargeController.listAssignChildrenToday.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AssignChildTile(
                                    assignChild: homeChargeController.listAssignChildrenToday[index],
                                  );
                                }
                            ),
                          ]
                        )
                      );
                    }
                  })
              )
            ),
            //Programaciones / Futuras
            SafeArea(
              child: BackgroundColorSafe(
                colorBackground: colorBackgroundWhite,
                  child: Obx(() {
                    if(homeChargeController.loadingFuture.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(homeChargeController.listAssignChildrenProgram.isEmpty){
                      return EmptyStateApp(
                              pathImage: "assets/images/box.png", 
                              messageEmpty: "No se encontraron autorizaciones programadas", 
                              colorState: Colors.black
                      );
                    } else {
                      return SingleChildScrollView(
                        child: ListView.builder(
                          primary: false,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: homeChargeController.listAssignChildrenProgram.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AssignChildTile(
                              assignChild: homeChargeController.listAssignChildrenProgram[index],
                            );
                          }
                        )
                      );
                    }
                  })
                )
              )
          ]
        )
      )
    );     
  }
}