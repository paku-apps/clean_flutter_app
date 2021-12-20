import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class TextAppNormal extends StatelessWidget {

  String text;
  Color color;

  TextAppNormal({
    Key? key,
    required this.text,
    required this.color
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: Text(text, style: const TextStyle(fontSize: textSizeNormalLabel, fontWeight: FontWeight.normal, color: whiteColor),),
    );
  }
}