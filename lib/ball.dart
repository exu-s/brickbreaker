// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final ballX;
  final ballY;
  const MyBall({Key? key, required this.ballX, required this.ballY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
