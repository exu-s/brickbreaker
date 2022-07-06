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

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  // ball variables
  double ballX = 0.0;
  double ballY = 0.0;
  double ballXincrements = 0.01;
  double ballYincrements = 0.01;

  double playerX = -0.2;
  double playerWidth = 0.4;
  var ballXDirection = direction.LEFT;
  var ballYDirection = direction.DOWN;

  bool hasGameStarted = false;
  bool isGameOver = false;

  static double firstBrickX = -0.5;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.04;
  bool brickBroken = false;
  static double brickGap = 0.2;

  List myBricks = [
    [firstBrickX, firstBrickY, false],
    [firstBrickX + brickWidth + brickGap, firstBrickY, false],
  ];
  // start game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 20), (timer) {
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
    if (ballX >= myBricks[0][0] &&
        ballX <= myBricks[0][0] + brickWidth &&
        ballY <= myBricks[0][1] + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
        ballYDirection = direction.DOWN;
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
    // ball up when it hits the player
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballYDirection = direction.UP;
    }
    // ball goes down when it hits the top screen
    else if (ballY <= -1) {
      ballYDirection = direction.DOWN;
    }

    if (ballX >= 1) {
      ballXDirection = direction.LEFT;
    } else if (ballX <= -1) {
      ballXDirection = direction.RIGHT;
    }
  }

  void moveBall() {
    setState(() {
      // move vertically
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrements;
      }

      // move horizontally
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrements;
      }
    });
  }

  // move left
  void moveLeft() {
    setState(() {
      // only if doesnt go off the screen left
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.2;
      }
    });
  }

  // move right
  void moveRight() {
    setState(() {
      // only if doesnt go off the screen right
      if (!(playerX + 0.4 >= 1)) {
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
                  brickX: myBricks[0][0],
                  brickY: myBricks[0][1],
                  brickBroken: brickBroken,
                ),
                MyBrick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[1][0],
                  brickY: myBricks[1][1],
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
