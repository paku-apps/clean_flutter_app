import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';

class EmptyStateApp extends StatelessWidget {

  String pathImage;
  String messageEmpty;
  Color colorState;

  EmptyStateApp({
    Key? key,
    required this.pathImage,
    required this.messageEmpty,
    required this.colorState
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(pathImage, fit: BoxFit.cover, height: 150, width: 150),
          const SizedBox(height: dimenMedium),
          TextAppNormal(text: messageEmpty, color: colorState)
        ]
      )
    );
  }
}