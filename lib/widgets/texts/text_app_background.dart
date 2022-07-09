import 'package:clean_app/constants/constants.dart';
import 'package:flutter/widgets.dart';

class TextAppBackground extends StatelessWidget {
  
  String text;
  Color colorBackground;

  TextAppBackground({
    Key? key,
    required this.text,
    required this.colorBackground
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        background: Paint()
          ..color = colorBackground
          ..strokeWidth = 20
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
          color: whiteColor
      ),
    );
  }
}