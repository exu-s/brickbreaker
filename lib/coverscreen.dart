// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;

  const CoverScreen({Key? key, required this.hasGameStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.1),
            child: Text(
              'TAP TO PLAY',
              style: GoogleFonts.pressStart2p(
                color: Colors.white,
              ),
            ),
          );
  }
}
