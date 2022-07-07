// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;

  const CoverScreen(
      {Key? key, required this.hasGameStarted, required this.isGameOver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: Alignment(0, -0.5),
            child: Text(
              isGameOver ? '' : 'BRICK BREAKER BY PWOFESOR',
              style: GoogleFonts.pressStart2p(
                  color: Colors.greenAccent, fontSize: 10),
            ),
          )
        : Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.5),
                child: Text(
                  'BRICK BREAKER',
                  style: GoogleFonts.pressStart2p(
                      color: Colors.white, fontSize: 25),
                ),
              ),
              Container(
                alignment: Alignment(0, -0.1),
                child: Text(
                  'TAP TO PLAY',
                  style: GoogleFonts.pressStart2p(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
  }
}
