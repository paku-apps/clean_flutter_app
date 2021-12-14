import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/widgets/inputs/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final IconData icon;
  const RoundedPasswordField({
    Key? key,
    this.icon = Icons.lock,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white),
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(color: Colors.white70),
          icon: Icon(
            icon,
            color: whiteColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: whiteColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}