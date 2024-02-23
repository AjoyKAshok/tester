import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({this.child});

  final child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
          ),
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.centerRight,
          //     colors: [Color(0xFFB4B5B9), Color(0xFFF58426)])),
          child: child,
        ),
        Image(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          image: AssetImage('images/Pattern.png'),
        ),
      ],
    );
  }
}
