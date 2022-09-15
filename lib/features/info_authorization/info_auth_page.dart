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
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:clean_app/widgets/texts/text_app_normal_bold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoAuthorizationPage extends StatelessWidget {
  const InfoAuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                  margin: const EdgeInsets.fromLTRB(dimenMedium, dimenMedium, dimenMedium, dimenMedium),
                  child: const Center(child: CircularProgressIndicator(),)
                );
              } else if (infoController.isLoading.value == false && infoController.mainCharger.value.idAutorizado == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ 
                    TextAppNormal(text: "No se pudo encontrar la información solicitada, intente nuevamente", color: textPrimaryColor)
                  ]
                );
              } else if (infoController.isLoading.value == false && infoController.mainCharger.value.idAutorizado == 999999) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ 
                    TextAppNormal(text: "No se encontraron alumnos para recoger", color: textPrimaryColor)
                  ]
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
                  Row(
                    children: [
                      TextAppNormalBold(
                        text: infoAuthorizationChildren,
                        color: textPrimaryColor,
                        noPaddingVertical: false
                      ),
                      SizedBox(width: 10),
                      Text(
                        infoController.listAuthConfirm.where((i) => i.check == true).length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          background: Paint()
                            ..color = primaryColor
                            ..strokeWidth = 20
                            ..strokeJoin = StrokeJoin.round
                            ..strokeCap = StrokeCap.round
                            ..style = PaintingStyle.stroke,
                            color: whiteColor
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Checkbox(value: infoController.isCheckForAll.value, onChanged: (value) {
                               infoController.checkAllChildren();
                        })
                      )
                    ]
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
                    child: const Divider(
                      thickness: 2,
                      color: disableColor,
                    ),
                  ),
                  ListView.builder(
                      primary: false,
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
                                  //isEnable: index>1 ? true : false
                                ),
                            ),
                            infoController.mainCharger.value.estudiantes![index].visible ?
                              Checkbox(value: infoController.mainCharger.value.estudiantes![index].marcar, onChanged: (value) {
                                infoController.checkChild(index);
                              })
                              : const SizedBox(width: 5)
                          ]
                        );
                      }
                  ),
                  Obx((){
                    if(infoController.isLoadingRegister.value){
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: RoundedButton(text: infoAuthorizationConfirm, press: () {
                        infoController.registerAuthorization();
                      }));
                    }
                  })
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