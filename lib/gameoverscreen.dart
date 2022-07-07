import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;
  const GameOverScreen(
      {Key? key, required this.isGameOver, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.1),
                child: Text(
                  'GAME OVER',
                  style: GoogleFonts.pressStart2p(color: Colors.white),
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.black,
                      child: Text(
                        'P L A Y   A G A I N',
                        style: GoogleFonts.pressStart2p(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
