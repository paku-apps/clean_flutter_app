import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';

class ChargerTile extends StatelessWidget {

  String name;
  String lastName;

  ChargerTile({
    Key? key,
    required this.name,
    required this.lastName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(dimenSmall, dimenLittle, dimenSmall, dimenLittle),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarCircleInitials(firstName: name, lastName: lastName),
          Container(
            padding: EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAppNormal(text: name + emptySpace + lastName, color: textPrimaryColor, noPaddingVertical: true)
              ],
            )
          )
        ],
      )
    );
  }
}