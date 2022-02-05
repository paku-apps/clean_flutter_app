import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextAppNormalAvatar extends StatelessWidget {

  String text;
  Color color;
  bool noPaddingVertical;

  TextAppNormalAvatar({
    Key? key,
    this.noPaddingVertical = false,
    required this.text,
    required this.color
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return Container(
      width: getResponsiveWidthText(deviceData),
      padding: noPaddingVertical ? const EdgeInsets.fromLTRB(dimenSmall, 0, dimenSmall, 0) : const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: Text(text, style: TextStyle(fontSize: textSizeNormalLabel, fontWeight: FontWeight.normal, color: color),),
    );
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
      return 280;
    }
  }
}