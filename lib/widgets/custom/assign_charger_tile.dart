import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign_charger.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';

class AssignChargerTile extends StatelessWidget {

  AutorizacionEstudianteModel assignEstudiante;

  AssignChargerTile({
    Key? key,
    required this.assignEstudiante
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(dimenSmall, dimenLittle, dimenSmall, dimenLittle),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarCircleInitials(firstName: assignEstudiante.nombres, lastName: assignEstudiante.apPaterno),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, dimenMedium, dimenMedium, dimenMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAppNormal(text: assignEstudiante.nombres + emptySpace + assignEstudiante.apPaterno, color: textPrimaryColor, noPaddingVertical: true),
                  TextAppNormal(text: assignEstudiante.grado , color: textPrimaryColor, noPaddingVertical: true)
                ],
              )
            )
          )
        ],
      )
    );
  }
}