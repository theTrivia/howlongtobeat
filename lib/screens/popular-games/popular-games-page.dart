import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hltb/screens/popular-games/popular-games.dart';
import 'package:provider/provider.dart';

import '../../project-variables.dart';
import '../../providers/show-overlaw-loader-provider.dart';

class PopularGamesPage extends StatelessWidget {
  const PopularGamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:
          (context.watch<ShowOverlayLoaderProvider>().shouldShowOverlayLoader ==
                  false)
              ? () {
                  exit(0);
                }
              : () {
                  return Future.value(false);
                },
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          // color: Colors.black.withOpacity(100),
          gradient: ProjectVariables.BACKGROUND_GRADIENT,
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Popular Games',
                style: GoogleFonts.staatliches(
                  color: ProjectVariables.SEXY_WHITE,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const PopularGames(),
          ],
        )),
      )),
    );
  }
}
