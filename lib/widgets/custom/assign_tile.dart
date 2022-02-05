import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:clean_app/widgets/texts/text_app_normal_avatar.dart';
import 'package:clean_app/widgets/texts/text_app_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignTile extends StatelessWidget {

  Assign assign;

  AssignTile({
    Key? key,
    required this.assign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(isMobile()){
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(dimenSmall, dimenTiny, dimenSmall, dimenTiny),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(assign.charger!.foto!),
                    radius: 28,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, dimenLittle, dimenMedium, dimenLittle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    TextTileWidgetTitle(text: assign.charger!.apPaterno! + emptySpace + assign.charger!.apMaterno! + separatorComma + emptySpace+ assign.charger!.nombres!, color: textPrimaryColor),  
                    TextAppNormal(text: transformStringDateTimeToAppFormat(assign.fechaInicio!, assign.fechaFin! ), color: textPrimaryColorDisable, noPaddingVertical: true),
                    TextAppNormal(text: assign.etapa!.nombre!, color: textPrimaryColor, noPaddingVertical: true)
                  ],
                )
              )
            )
          ],
        )
      );
    } else {
      return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(dimenSmall, dimenTiny, dimenSmall, dimenTiny),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(assign.charger!.foto!),
                  radius: 28,
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, dimenLittle, dimenMedium, dimenLittle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                TextTileWidgetTitle(text: assign.charger!.apPaterno! + emptySpace + assign.charger!.apMaterno! + separatorComma + emptySpace+ assign.charger!.nombres!, color: textPrimaryColor),  
                TextAppNormalAvatar(text: transformStringDateTimeToAppFormat(assign.fechaInicio!, assign.fechaFin! ), color: textPrimaryColorDisable, noPaddingVertical: true),
                TextAppNormalAvatar(text: assign.etapa!.nombre!, color: textPrimaryColor, noPaddingVertical: true)
              ],
            )
          )
        ],
      )
    );
    }

    
  }
}