import 'package:flutter/material.dart';
import 'package:hltb/components/loading-anime.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/games-list/games-list.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var shouldWeLoad = false;
  @override
  Widget build(BuildContext context) {
    var gameSearchEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          const Text(
            'howlongtobeat',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              TextFormField(
                controller: gameSearchEditingController,
              ),
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    shouldWeLoad = true;
                  });
                  await Provider.of<SearchGameProvider>(context, listen: false)
                      .searchGames(gameSearchEditingController.text);
                  setState(() {
                    shouldWeLoad = false;
                  });
                },
                child: const Text('Search'),
              ),
            ],
          ),
          (shouldWeLoad == true) ? LoadingAnime() : GamesList(),
        ],
      )),
    );
  }
}
