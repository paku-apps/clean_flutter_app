import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class TextAppNormalBold extends StatelessWidget {

  String text;
  Color color;
  bool noPaddingVertical;

  TextAppNormalBold({
    Key? key,
    this.noPaddingVertical = false,
    required this.text,
    required this.color
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: noPaddingVertical ? const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0) : const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: Text(text, style: TextStyle(fontSize: textSizeNormalLabel, fontWeight: FontWeight.bold, color: color),),
    );
  }
}