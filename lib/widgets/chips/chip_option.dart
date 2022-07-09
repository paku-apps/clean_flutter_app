import 'package:clean_app/constants/constants.dart';
import 'package:flutter/material.dart';

class ChipOption extends StatelessWidget {
  
  final String text;
  final Function press;
  final Color backgroundColor, textColor;

  const ChipOption({
    Key? key,
    required this.text,
    required this.press,
    this.backgroundColor = primaryColor,
    this.textColor = whiteColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: primarySelected
        ),
        color: primarySelected,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(this.text, style: TextStyle(color: whiteColor),),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.close),
              color: Colors.white,
              onPressed: () { press(); },
            )
          ]
        ),
    );
  }
}