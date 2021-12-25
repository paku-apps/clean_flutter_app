
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class TextFormFieldIconNormal extends StatelessWidget {

  final ValueChanged<String> onChanged;
  bool showPassword;
  TextEditingController controller;
  Function validatorFunction;
  String valueData;
  IconData? leftIcon;

  TextFormFieldIconNormal({
    Key? key,
    required this.onChanged,
    this.showPassword = false,
    this.leftIcon,
    required this.controller,
    required this.validatorFunction,
    this.valueData = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, 0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: primaryColor),
        cursorColor: primaryColor,
        onSaved: (value) {
          valueData = value!;
        },
        validator: (value) {
          return validatorFunction(value!);
        },
        decoration: InputDecoration(
          hintText: "Correo electrónico",
          hoverColor: primaryColor,
          hintStyle: const TextStyle(color: primaryColor),
          filled: true,
          fillColor: whiteColor,
          prefixIcon: leftIcon != null ?Icon(
            leftIcon,
            color: primaryColor
          ) : null,
        ),
      )
    );
  }
}