
import 'dart:io';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class CircleAvatarFile extends StatelessWidget {

  File imageFile;

  CircleAvatarFile({
    Key? key,
    required this.imageFile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(180.0),
          child: Image.file(
              imageFile,
              fit: BoxFit.cover,
              height: 180.0,
              width: 180.0,
          ),
      )
    );
  }
}