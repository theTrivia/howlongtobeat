import 'package:flutter/material.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/games-list/games-list.dart';
import 'package:http/http.dart' as http;
import 'package:hltb/screens/game-card/game-card.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var gameSearchEditingController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              TextFormField(
                controller: gameSearchEditingController,
              ),
              RaisedButton(
                onPressed: () async {
                  // await http
                  //     .get(Uri.parse(
                  //         'http://192.168.0.182:3000/getGames/call of duty vanguard'))
                  //     .then(
                  //       (value) => print(value.body),
                  //     );
                  await Provider.of<SearchGameProvider>(context, listen: false)
                      .searchGames(gameSearchEditingController.text);

                  // print(context.watch<SearchGameProvider>().searchResult);
                },
                child: Text('Search'),
              ),
            ],
          ),
          GamesList(),
        ],
      )),
    );
  }
}
