import 'dart:convert';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/info_authorization/info_auth_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/custom/assign_charger_tile.dart';
import 'package:clean_app/widgets/custom/charger_tile.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/texts/text_app_normal_bold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class InfoAuthorizationPage extends StatelessWidget {
  const InfoAuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final infoController = Get.put(InfoAuthorizationController());

    Size size = MediaQuery.of(context).size;
    var argumentitos = Get.arguments;
    var qrValue = json.decode(argumentitos[0]);

    final infoController = Get.put(InfoAuthorizationController());
    infoController.qrToDecoded.value = qrValue;
    infoController.getDetailFromQR();

    return GetBuilder<InfoAuthorizationController>(
      init: InfoAuthorizationController(),
      builder: (infoController) => Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarBackNav(
          title: infoAuthorizationTitle
        )
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: Obx(() {
              if(infoController.isLoading.value){
                return Container(
                  margin: EdgeInsets.fromLTRB(dimenMedium, dimenMedium, dimenMedium, dimenMedium),
                  child: Center(child: CircularProgressIndicator(),)
                );
              } else {
                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAppNormalBold(
                    text: infoAuthorizationCharger,
                    color: textPrimaryColor,
                    noPaddingVertical: false
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ChargerTile(name: infoController.mainCharger.value.nombres, lastName: infoController.mainCharger.value.apPaterno+emptySpace+infoController.mainCharger.value.apMaterno),
                  ),
                  TextAppNormalBold(
                    text: infoAuthorizationChildren,
                    color: textPrimaryColor,
                    noPaddingVertical: false
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: infoController.mainCharger.value.estudiantes?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Expanded(
                              child: AssignChargerTile(
                                  assignEstudiante: infoController.mainCharger.value.estudiantes![index],
                                ),
                            ),
                            Checkbox(value: infoController.mainCharger.value.estudiantes![index].checked, onChanged: (value) {
                              infoController.checkChild(index);
                            })
                          ]
                        );
                      }
                  ),
                  Center(child: RoundedButton(text: infoAuthorizationConfirm, press: () {}))
                ],
                );
              }
            }
            )
          )
        )
      )
    )
    );
  }
}