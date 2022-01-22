import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class TextAppTitle extends StatelessWidget {

  String text;
  Color color;

  TextAppTitle({
    Key? key,
    required this.text,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: Text(text, style: TextStyle(fontSize: textSizeTitleApp, fontWeight: FontWeight.bold, color: color),),
    );
  }
}

class TextTileWidgetTitle extends StatelessWidget {

  String text;
  Color color;

  TextTileWidgetTitle({
    Key? key,
    required this.text,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenSmall, dimenTiny, dimenSmall, dimenTiny),
      child: Text(text, style: TextStyle(fontSize: textSizeNormalLabel, fontWeight: FontWeight.bold, color: color),),
    );
  }
}