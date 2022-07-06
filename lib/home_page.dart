// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:brickbreaker/ball.dart';
import 'package:brickbreaker/brick.dart';
import 'package:brickbreaker/coverscreen.dart';
import 'package:brickbreaker/gameoverscreen.dart';
import 'package:brickbreaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  // ball variables
  double ballX = 0;
  double ballY = 0;

  double playerX = -0.2;
  double playerWidth = 0.4;
  var ballDirection = direction.DOWN;

  bool hasGameStarted = false;
  bool isGameOver = false;

  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.04;
  bool brickBroken = false;

  // start game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        // move the ball
        moveBall();

        // update direction
        updateDirection();

        // game over check
        if (isPlayerDead()) {
          timer.cancel();
          isGameOver = true;
        }

        // is brick dead
        checkBrokenBricks();
      });
    });
  }

  void checkBrokenBricks() {
    if (ballX >= brickX &&
        ballX <= brickX + brickWidth &&
        ballY <= brickY + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
        ballDirection = direction.DOWN;
      });
    }
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballDirection = direction.UP;
    } else if (ballY <= -1) {
      ballDirection = direction.DOWN;
    }
  }

  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  // move left
  void moveLeft() {
    setState(() {
      // only if doesnt go off the screen left
      if (!(playerX - 0.2 <= -1)) {
        playerX -= 0.2;
      }
    });
  }

  // move right
  void moveRight() {
    setState(() {
      // only if doesnt go off the screen right
      if (!(playerX + 0.2 >= 1)) {
        playerX += 0.2;
      }
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

                // game over screen
                GameOverScreen(isGameOver: isGameOver),

                // the ball
                MyBall(ballX: ballX, ballY: ballY),

                // player
                MyPlayer(playerX: playerX, playerWidth: playerWidth),

                // bricks to hit
                MyBrick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: brickX,
                  brickY: brickY,
                  brickBroken: brickBroken,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
