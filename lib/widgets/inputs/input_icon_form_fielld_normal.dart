
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/widgets/labels/label_tap.dart';
import 'package:flutter/material.dart';

class TextFormFieldIconNormal extends StatelessWidget {

  final ValueChanged<String> onChanged;
  bool showPassword;
  TextEditingController controller;
  Function validatorFunction;
  String valueData;
  IconData? leftIcon;
  String label;
  String hint;

  TextFormFieldIconNormal({
    Key? key,
    required this.onChanged,
    this.showPassword = false,
    this.leftIcon,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validatorFunction,
    this.valueData = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(dimenExtraLarge, dimenMedium, dimenExtraLarge, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: textSizeNormalLabel, fontWeight: FontWeight.bold),),
          TextFormField(
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
              hintText: hint,
              hintStyle: const TextStyle(color: textPrimaryColorUnselected),
              filled: true,
              fillColor: whiteColor,
              prefixIcon: leftIcon != null ?Icon(
                leftIcon,
                color: primaryColor
              ) : null,
            ),
          )
        ]
      )
    );
  }
}