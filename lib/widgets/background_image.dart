import 'package:flutter/cupertino.dart';

class BackgroundImage extends StatelessWidget{
  
  final Widget child;
  const BackgroundImage({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/fondo.png",
              width: size.width * 1,
            ),
          ),
          child,
        ],
      ),
    );
  }
}