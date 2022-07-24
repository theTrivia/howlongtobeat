import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hltb/screens/game-detail/game-detail.dart';

import '../../common/play-time-board.dart';

class GameCard extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String gameplayMain;
  final String gameplayMainExtra;
  final String gameplayCompletionist;

  GameCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.gameplayMain,
    required this.gameplayMainExtra,
    required this.gameplayCompletionist,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetail(id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
          color: const Color.fromARGB(18, 199, 198, 198),
          // height: 100,
          child: Row(
            children: [
              Image.network(
                'https://howlongtobeat.com' + imageUrl,
                height: 100,
                width: 80,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Text(
                            (name.length > 22)
                                ? '${name.substring(0, 22)}...'
                                : name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        PlayTimeBoard(
                          gameplayMain: gameplayMain,
                          gameplayMainExtra: gameplayMainExtra,
                          gameplayCompletionist: gameplayCompletionist,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
