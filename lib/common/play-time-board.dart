import 'package:flutter/material.dart';

class PlayTimeBoard extends StatelessWidget {
  final String gameplayMain;
  final String gameplayMainExtra;
  final String gameplayCompletionist;

  PlayTimeBoard({
    required this.gameplayMain,
    required this.gameplayMainExtra,
    required this.gameplayCompletionist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
    );
  }
}
