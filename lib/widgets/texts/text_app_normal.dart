import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextAppNormal extends StatelessWidget {

  String text;
  Color color;
  bool noPaddingVertical;
  double textSize;
  TextAlign textAlign;

  TextAppNormal({
    Key? key,
    this.noPaddingVertical = false,
    this.textAlign = TextAlign.left,
    required this.text,
    required this.color,
    this.textSize = textSizeNormalLabel
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isForDevice = isMobile();
    if(isForDevice){
      return Container(
        padding: noPaddingVertical ? const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0) : const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
        child: Text(text, style: TextStyle(fontSize: textSize, fontWeight: FontWeight.normal, color: color), textAlign: textAlign,),
      );
    } else {
      var deviceData = MediaQuery.of(context);
      return Container(
        width: getResponsiveWidthText(deviceData),
        padding: noPaddingVertical ? const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0) : const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
        child: Text(text, style: TextStyle(fontSize: textSize, fontWeight: FontWeight.normal, color: color), textAlign: textAlign,),
      );
    }
  }

  double getResponsiveWidthText(MediaQueryData mediaQueryData){
    if(mediaQueryData.size.width>950){
      //Desktop
      return 700;
    } else if(mediaQueryData.size.width>600){
      //Tablet
      return 500;
    } else {
      //Size Mobile
      return 450;
    }
  }
}