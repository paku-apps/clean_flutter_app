import 'dart:convert';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/features/detail_assign/detail_assign_controller.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav_options.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:clean_app/widgets/texts/text_app_normal_bold.dart';
import 'package:clean_app/widgets/texts/text_app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailAssignPage extends StatelessWidget {
  DetailAssignPage({Key? key}) : super(key: key);
 
  final detailAssignController = Get.put(DetailAssignController());

  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);
    var argumentitos = Get.arguments;
    var assign = json.decode(argumentitos[0]);
    var listChildSelected = assign["estudiantes"].where((estudiante) => estudiante["isChecked"] == true).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child:  AppBarBackNavOptions(
          title: listAssignsTitle,
          listIcons: const [Icon(Icons.edit), Icon(Icons.delete)],
          listFunctions: [
            () {detailAssignController.goToUpdateAssign(assign);}, 
            () {
              showDialog(
                context: context, 
                builder: (_) => AlertDialog(
                  title: TextAppTitle(text: listAssignsEditTitle, color: textPrimaryColor),
                  content: TextAppNormal(text: listAssignsEditMessage,color: textPrimaryColor, noPaddingVertical: true,),
                  actions: [
                    Obx((){
                      if(detailAssignController.isLoading.value){
                        return const CircularProgressIndicator();
                      } else {
                        return TextButton(onPressed: () {
                          detailAssignController.deleteAssign(assign);  
                        }, 
                        child: const Text(listAssignsEditOk),);
                      }
                    }),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text(listAssignsEditCancel),)
                  ],
                ),
                barrierDismissible: true,
              );
            }],
        )
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container( //FormAutocompletado
                      width: isMobile() ? deviceData.size.width : getResponsiveWidthContainer(deviceData),
                      margin: const EdgeInsets.fromLTRB(dimenLarge, dimenSmall, dimenLarge, dimenSmall),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(dimenSmall),
                            child: const Icon(Icons.account_box, size: 36),
                          ),
                          Expanded(child: SizedBox(
                            child: Text(assign["charger"]["ap_paterno"] +emptySpace + assign["charger"]["ap_materno"] + ", " + assign["charger"]["nombres"]),
                          ))
                        ]
                      )
                    ),
                    Container( //FormAutocompletado
                      width: isMobile() ? deviceData.size.width : getResponsiveWidthContainer(deviceData),
                      margin: const EdgeInsets.fromLTRB(dimenLarge, dimenSmall, dimenLarge, dimenSmall),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(dimenSmall),
                            child: const Icon(Icons.calendar_today, size: 36),
                          ),
                          Expanded(child: SizedBox(
                            child: Text(transformStringDateTimeToAppFormat(assign["fechaInicio"], assign["fechaFin"])),
                          ))
                        ]
                      )
                    ),
                    TextAppNormalBold(text: "Alumnos a recoger con la autorización", color: textPrimaryColor),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: listChildSelected.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Expanded(
                              child: ChildTile(
                                  child: Child.fromJson(listChildSelected[index]),
                              ),
                            )
                          ]
                        );
                      }
                    )
                  ]
                )
              )
            )
          )
        );
    }
  }