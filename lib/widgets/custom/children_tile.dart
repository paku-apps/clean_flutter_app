import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';

class ChildTile extends StatelessWidget {

  Child child;

  ChildTile({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(dimenSmall, dimenLittle, dimenSmall, dimenLittle),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarCircleInitials(firstName: child.nombres, lastName: child.apPaterno),
          Container(
            padding: EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAppNormal(text: child.nombres + emptySpace + child.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                TextAppNormal(text: child.grado?.nombre ?? "" , color: textPrimaryColor, noPaddingVertical: true)
              ],
            )
          )
        ],
      )
    );
  }
}