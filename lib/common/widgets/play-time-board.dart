import 'package:flutter/material.dart';

class PlayTimeBoard extends StatelessWidget {
  final String gameplayMain;
  final String gameplayMainExtra;
  final String gameplayCompletionist;

  final double cardHeight;
  final double circularBorderRadius;

  PlayTimeBoard({
    required this.gameplayMain,
    required this.gameplayMainExtra,
    required this.gameplayCompletionist,
    required this.cardHeight,
    required this.circularBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circularBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: cardHeight,
            color: Colors.blue,
            child: Row(
              children: [
                const Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      'Main Story',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      gameplayMain + ' hours',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: cardHeight,
            color: Colors.purple,
            child: Row(
              children: [
                const Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      'Main + Extra',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      gameplayMainExtra + ' hours',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: cardHeight,
            color: Colors.red,
            child: Row(
              children: [
                const Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      'Completionist',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      gameplayCompletionist + ' hours',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
