import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {

  String message;
  Color status;

  SnackBarMessage({
    Key? key,
    required this.message,
    required this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message, style: const TextStyle(fontSize: textSizeNormalLabel, color: whiteColor),),
      backgroundColor: status,
      behavior: SnackBarBehavior.floating
    );
  }
}