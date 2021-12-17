import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimentsions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedTextFormFieldPass extends StatelessWidget {

  final ValueChanged<String> onChanged;
  final IconData icon;
  bool showPassword;
  Function functionTapIcon;
  TextEditingController controller;
  Function validatorFunction;
  String valueData;
  IconData? leftIcon;

  RoundedTextFormFieldPass({
    Key? key,
    required this.onChanged,
    this.icon = Icons.lock,
    this.showPassword = false,
    this.leftIcon,
    required this.functionTapIcon,
    required this.controller,
    required this.validatorFunction,
    this.valueData = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenExtraBig, 0, dimenExtraBig, 0),
      child: TextFormField(
        obscureText: showPassword,
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
          hintText: "Contraseña",
          hoverColor: primaryColor,
          hintStyle: const TextStyle(color: primaryColor),
          filled: true,
          fillColor: primaryColorLight,
          prefixIcon: leftIcon != null ?Icon(
            leftIcon,
            color: primaryColor
          ) : null,
          suffixIcon: IconButton(
            icon: Icon( 
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: primaryColor
            ),
            onPressed: () => functionTapIcon(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: primaryColorLight
            ),
          ),
        ),
      )
    );
  }
}