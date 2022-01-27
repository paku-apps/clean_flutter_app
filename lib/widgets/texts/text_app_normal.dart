import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextAppNormal extends StatelessWidget {

  String text;
  Color color;
  bool noPaddingVertical;

  TextAppNormal({
    Key? key,
    this.noPaddingVertical = false,
    required this.text,
    required this.color
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: noPaddingVertical ? const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0) : const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: Text(text, style: TextStyle(fontSize: textSizeNormalLabel, fontWeight: FontWeight.normal, color: color),),
    );
  }
}