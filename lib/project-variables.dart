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

  static LinearGradient BACKGROUND_GRADIENT = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [
      0.5,
      0.8,
    ],
    colors: [
      Color.fromARGB(247, 2, 4, 29),
      Colors.black,
    ],
  );

  static Color SEXY_WHITE = Color.fromARGB(247, 232, 232, 232);
  static Color SEXY_WHITE_LOW = Color.fromARGB(158, 232, 232, 232);
}
