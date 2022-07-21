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
      print(result.body);
      setState(() {
        gameDetail = result.body;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: getGameDetail(widget.gameId),
        builder: ((context, snapshot) {
          return Text(gameDetail.toString());
        }),
      )),
    );
  }
}
