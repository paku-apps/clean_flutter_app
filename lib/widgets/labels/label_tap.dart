
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class TextLabelTap extends StatelessWidget {

  final String textLabel;
  final Function press;

  const TextLabelTap({
    Key? key,
    required this.press,
    required this.textLabel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => press(),
      child: Text(
        textLabel,
        style: const TextStyle(
          fontSize: textSizeNormalLabel,
          color: textPrimaryColor
        ),
      ),
    );
  }
}
