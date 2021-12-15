import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/widgets/inputs/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: primaryColor),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: primaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}