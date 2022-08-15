import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../project-variables.dart';

class EmptyFavList extends StatelessWidget {
  const EmptyFavList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
          child: Text(
        'Please start adding games...',
        style: GoogleFonts.barlowCondensed(
          color: ProjectVariables.SEXY_WHITE,
          // fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      )),
    );
  }
}
