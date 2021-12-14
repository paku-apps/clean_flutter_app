import 'package:flutter/cupertino.dart';

class BackgroundColor extends StatelessWidget {
  
  final Widget child;
  final Color colorBackground;

  const BackgroundColor({
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
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}
