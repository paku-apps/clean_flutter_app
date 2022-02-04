import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextFormFieldNormal extends StatelessWidget {

  final ValueChanged<String> onChanged;
  bool showPassword;
  TextEditingController controller;
  Function validatorFunction;
  String valueData;
  IconData? leftIcon;

  RoundedTextFormFieldNormal({
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

    var deviceData = MediaQuery.of(context);
      //width: deviceData.size.width > 600 ? 300 : 400 ,

    return Container(
      width: getResponsiveLenght(deviceData),
      padding: const EdgeInsets.fromLTRB(dimenExtraBig, 0, dimenExtraBig, 0),
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
          fillColor: primaryColorLight,
          prefixIcon: leftIcon != null ?Icon(
            leftIcon,
            color: primaryColor
          ) : null,
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

  double getResponsiveLenght(MediaQueryData mediaQueryData){
    if(mediaQueryData.size.width>950){
      //Desktop
      return 700;
    } else if(mediaQueryData.size.width>600){
      //Tablet
      return 400;
    } else {
      //Size Mobile
      return 200;
    }
  }
}