import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal_avatar.dart';
import 'package:flutter/material.dart';

class ChildTile extends StatelessWidget {

  Child child;
  bool hasCheckBox;

  ChildTile({
    Key? key,
    required this.child,
    this.hasCheckBox = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var deviceData = MediaQuery.of(context);
    var isForDevice = isMobile();
    
    if(isForDevice){
      return Container(
        margin: const EdgeInsets.fromLTRB(dimenSmall, dimenLittle, dimenSmall, dimenLittle),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircleInitials(firstName: child.nombres, lastName: child.apPaterno),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAppNormalAvatar(text: child.nombres + emptySpace + child.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                    TextAppNormalAvatar(text: child.grado?.nombre ?? "" , color: textPrimaryColor, noPaddingVertical: true)
                  ],
                )
              )
            )
          ],
        )
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(dimenSmall, dimenLittle, dimenSmall, dimenLittle),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarCircleInitials(firstName: child.nombres, lastName: child.apPaterno),
            Container(
              width: hasCheckBox ? getResponsiveWidthContainerCheckbox(deviceData) : getResponsiveWidthContainer(deviceData),
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAppNormalAvatar(text: child.nombres + emptySpace + child.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                  TextAppNormalAvatar(text: child.grado?.nombre ?? "" , color: textPrimaryColor, noPaddingVertical: true)
                ],
              )
            )
          ],
        )
      );
    }    
  }
}