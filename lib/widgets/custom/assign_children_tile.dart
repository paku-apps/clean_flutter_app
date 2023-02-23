import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/custom/priority_lock_tile.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';

class AssignChildTile extends StatelessWidget {

  AssignChildModel assignChild;
  Function actionPriority;
  bool visibleForRolePlus;

  AssignChildTile({
    Key? key,
    required this.assignChild,
    required this.actionPriority,
    required this.visibleForRolePlus
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);

    if(isMobile()){
      return Container(
        margin: const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircleInitials(firstName: assignChild.nombres, lastName: assignChild.apPaterno),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
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
            ),
            visibleForRolePlus ? IconCheckPriority(child: assignChild, enabled: assignChild.priorizado, action:() => {actionPriority()}) : Container(),
          ],
        )
      ); 
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircleInitials(firstName: assignChild.nombres, lastName: assignChild.apPaterno),
            Container(
              width: getResponsiveWidthContainer(deviceData),
              padding: const EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAppNormal(text: assignChild.nombres + emptySpace + assignChild.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                  TextAppNormal(text: assignChild.grado?.nombre ?? "" , color: textPrimaryColor, noPaddingVertical: true),
                  TextAppNormal(text: getRangeOfChildAuthorizations(assignChild.autorizaciones!) , color: textPrimaryColorDisable, noPaddingVertical: true, textSize: textSizeMinimunLabel,)
                ],
              )
            ),
            visibleForRolePlus ? IconCheckPriority(child: assignChild, enabled: assignChild.priorizado, action:() => {actionPriority()}) : Container(),
          ],
        )
      );
    }
  }
}