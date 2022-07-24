import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hltb/common/loading-anime.dart';
import 'package:hltb/common/play-time-board.dart';
import 'package:http/http.dart' as http;

class GameDetail extends StatefulWidget {
  final String gameId;
  GameDetail(this.gameId);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  var gameDetail;
  var shouldWeLoad = true;
  getGameDetail(gameId) async {
    try {
      var result = await http
          .get(Uri.parse('http://192.168.0.182:3000/gameDetail/' + gameId));
      // print(result.body);
      var formattedResult = jsonDecode(result.body)['result'];
      return formattedResult;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getGameDetail(widget.gameId).then((res) {
      print(res);
      setState(() {
        gameDetail = res;
        shouldWeLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: (gameDetail == null)
              ? const LoadingAnime()
              : Column(
                  children: [
                    Text(
                      gameDetail['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 72, 0, 255),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Image.network(
                                'https://howlongtobeat.com' +
                                    gameDetail['imageUrl'],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'How long to beat?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 0, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PlayTimeBoard(
                            gameplayMain: gameDetail['gameplayMain'].toString(),
                            gameplayMainExtra:
                                gameDetail['gameplayMainExtra'].toString(),
                            gameplayCompletionist:
                                gameDetail['gameplayCompletionist'].toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 0, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            gameDetail['description'],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Playable On',
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 0, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (gameDetail['playableOn'].length > 0)
                                ? gameDetail['playableOn'].toString().substring(
                                      1,
                                      gameDetail['playableOn']
                                              .toString()
                                              .length -
                                          1,
                                    )
                                : 'Not Available',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
