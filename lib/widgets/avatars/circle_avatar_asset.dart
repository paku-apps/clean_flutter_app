

import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class CircleAvatarAsset extends StatelessWidget {

  String pathAsset;

  CircleAvatarAsset({
    Key? key,
    required this.pathAsset
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(180.0),
          child: Image.asset(
              pathAsset,
              fit: BoxFit.contain,
              height: 180.0,
              width: 180.0,
          ),
      )
    );
  }
}