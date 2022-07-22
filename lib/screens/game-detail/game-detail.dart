import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GameDetail extends StatefulWidget {
  final String gameId;
  GameDetail(this.gameId);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  var gameDetail;
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: ListView(
            children: [
              Text(
                gameDetail['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.network(
                'https://howlongtobeat.com' + gameDetail['imageUrl'],
              ),
              Text('Description'),
              Text(gameDetail['description']),
              SizedBox(
                height: 10,
              ),
              Text('Playable On'),
              Text(gameDetail['playableOn'][0])
            ],
          ),
        ),
      ),
    );
  }
}
