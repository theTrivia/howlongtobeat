import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hltb/components/loading-anime.dart';
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
              : ListView(
                  children: [
                    Column(
                      children: [
                        Text(
                          gameDetail['name'],
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.network(
                          'https://howlongtobeat.com' + gameDetail['imageUrl'],
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
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
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          gameDetail['playableOn'][0],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
