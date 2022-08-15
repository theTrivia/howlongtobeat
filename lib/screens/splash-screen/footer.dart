import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hltb/project-variables.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectVariables.SEXY_WHITE,
      height: 40,
      child: Center(
        child: Text(
          'Made in 🇮🇳 with ❤️ by Soham Pal',
          style: GoogleFonts.barlowCondensed(
            color: ProjectVariables.MAIN_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
