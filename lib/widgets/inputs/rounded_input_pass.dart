import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/widgets/inputs/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {

  final ValueChanged<String> onChanged;
  final IconData icon;
  bool showPassword;
  Function functionTapIcon;

  RoundedPasswordField({
    Key? key,
    this.icon = Icons.lock,
    this.showPassword = false,
    required this.functionTapIcon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: !showPassword,
        style: TextStyle(color: primaryColor),
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(color: primaryColor),
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon( 
              !showPassword ? Icons.visibility : Icons.visibility_off,
              color: primaryColor
            ),
            onPressed: () {
              functionTapIcon();
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}