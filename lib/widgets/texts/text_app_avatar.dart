import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:flutter/material.dart';

class TextAppAvatar extends StatelessWidget {

  String first;
  String second;

  TextAppAvatar({
    Key? key,
    required this.first,
    required this.second,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
      child: Text(getInitialString(first)+getInitialString(second), style: const TextStyle(fontWeight: FontWeight.bold, color: whiteColor),),
    );
  }
}