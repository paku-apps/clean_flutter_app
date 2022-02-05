import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';

class AssignChildTile extends StatelessWidget {

  AssignChildModel assignChild;
  

  AssignChildTile({
    Key? key,
    required this.assignChild
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);

    if(isMobile()){
      return Container(
        margin: EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircleInitials(firstName: assignChild.nombres, lastName: assignChild.apPaterno),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAppNormal(text: assignChild.nombres + emptySpace + assignChild.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                    TextAppNormal(text: assignChild.grado?.nombre ?? "" , color: textPrimaryColor, noPaddingVertical: true),
                    TextAppNormal(text: getRangeOfChildAuthorizations(assignChild.autorizaciones!) , color: textPrimaryColorDisable, noPaddingVertical: true, textSize: textSizeMinimunLabel,)
                  ],
                )
              )
            )
          ],
        )
      ); 
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircleInitials(firstName: assignChild.nombres, lastName: assignChild.apPaterno),
            Container(
              width: getResponsiveWidthContainer(deviceData),
              padding: EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAppNormal(text: assignChild.nombres + emptySpace + assignChild.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                  TextAppNormal(text: assignChild.grado?.nombre ?? "" , color: textPrimaryColor, noPaddingVertical: true),
                  TextAppNormal(text: getRangeOfChildAuthorizations(assignChild.autorizaciones!) , color: textPrimaryColorDisable, noPaddingVertical: true, textSize: textSizeMinimunLabel,)
                ],
              )
            )
          ],
        )
      );
    }

    
  }
}