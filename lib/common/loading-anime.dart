import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnime extends StatelessWidget {
  const LoadingAnime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        // color: const Color.fromARGB(255, 28, 28, 198),
        color: const Color.fromARGB(255, 72, 0, 255),
        size: 100,
      ),
    );
  }
}
