import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/texts/text_app_avatar.dart';
import 'package:flutter/material.dart';

class AvatarCircleInitials extends StatelessWidget {

  String firstName;
  String lastName;

  AvatarCircleInitials({
    Key? key,
    required this.firstName,
    required this.lastName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(dimenSmall),
      decoration: const BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle
      ),
      child: TextAppAvatar(first: firstName, second: lastName),
    );
  }


}