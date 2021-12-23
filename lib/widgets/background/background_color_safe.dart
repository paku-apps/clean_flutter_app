import 'package:flutter/cupertino.dart';

class BackgroundColorSafe extends StatelessWidget {
  
  final Widget child;
  final Color colorBackground;

  const BackgroundColorSafe({
    Key? key,
    required this.child,
    
    required this.colorBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(color: colorBackground),
      child: Stack(
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}
