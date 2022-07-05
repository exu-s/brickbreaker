// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:html';
import 'package:brickbreaker/ball.dart';
import 'package:brickbreaker/coverscreen.dart';
import 'package:brickbreaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ball variables
  double ballX = 0;
  double ballY = 0;

  double playerX = 0;
  double playerWidth = 0.3;

  bool hasGameStarted = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        ballY -= 0.01;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Stack(
              children: [
                // tap to play
                CoverScreen(hasGameStarted: hasGameStarted),

                // the ball
                MyBall(ballX: ballX, ballY: ballY),

                // player
                MyPlayer(playerX: playerX, playerWidth: playerWidth)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
