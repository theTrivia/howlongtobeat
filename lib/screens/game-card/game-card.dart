import 'dart:ffi';

import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black87,
        height: 100,
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
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        // color: Colors.white,
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  gameplayMain,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('6 hours'),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.purple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  gameplayMainExtra,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('6 hours'),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  gameplayCompletionist,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('6 hours'),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
