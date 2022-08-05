import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../project-variables.dart';

class Metascore extends StatelessWidget {
  final String ms;
  const Metascore({required this.ms});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 10000,
      color: ProjectVariables.MAIN_COLOR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Metacritic Score',
            style: GoogleFonts.staatliches(
              color: ProjectVariables.SEXY_WHITE,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          Text(
            ms,
            style: GoogleFonts.staatliches(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
