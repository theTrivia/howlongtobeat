import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../project-variables.dart';

class LoadingAnime extends StatelessWidget {
  final Color color;
  LoadingAnime(this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        // color: const Color.fromARGB(255, 28, 28, 198),
        color: color,
        size: 100,
      ),
    );
  }
}
