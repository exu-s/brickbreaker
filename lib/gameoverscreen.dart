import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  const GameOverScreen({Key? key, required this.isGameOver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: Text(
              'G A M E   O V E R',
              style: GoogleFonts.pressStart2p(color: Colors.white),
            ),
          )
        : Container();
  }
}
