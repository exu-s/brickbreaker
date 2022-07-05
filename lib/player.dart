// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  final playerWidth;

  const MyPlayer({Key? key, required this.playerX, required this.playerWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 0.9),
      child: Container(
        height: 10,
        width: MediaQuery.of(context).size.width * playerWidth / 2,
        color: Colors.black,
      ),
    );
  }
}
