import 'dart:ui';

import 'package:flutter/material.dart';

class ProjectVariables {
  //color palette
  static Color MAIN_COLOR_DARK = const Color.fromARGB(178, 13, 0, 255);
  static Color MAIN_COLOR = const Color.fromARGB(255, 72, 0, 255);

  static Color BACKGROUND_COLOR = MAIN_COLOR;

  static Color INPUT_TEXT_COLOR_1 = const Color.fromARGB(255, 255, 255, 255);
  static Color HINT_TEXT_COLOR_1 = const Color.fromARGB(67, 255, 255, 255);
  static Color BORDER_COLOR_1 = const Color.fromARGB(255, 255, 255, 255);
  static Color FOCUSED_BORDER_COLOR_1 =
      const Color.fromARGB(255, 255, 255, 255);

  static Color INPUT_TEXT_COLOR_2 = MAIN_COLOR;
  static Color HINT_TEXT_COLOR_2 = MAIN_COLOR;
  static Color BORDER_COLOR_2 = MAIN_COLOR;
  static Color FOCUSED_BORDER_COLOR_2 = MAIN_COLOR;

  // static String METACRITIC_GAME_DETAIL_SERVER = 'http://localhost:5000/';
  static String METACRITIC_GAME_DETAIL_SERVER = 'http://192.168.0.182:5000/';
}
