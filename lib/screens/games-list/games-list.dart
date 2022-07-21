import 'package:flutter/material.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/game-card/game-card.dart';
import 'package:provider/provider.dart';

class GamesList extends StatefulWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  State<GamesList> createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  var searchResult = [];
  // @override
  // void initState() {
  //   super.initState();
  //   final searchResults = context.watch<SearchGameProvider>().searchResult;
  //   print(searchResults);
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: ((context, snapshot) {
      print(context.watch<SearchGameProvider>().searchResult);

      return Flexible(
          child: ListView.builder(
              itemCount:
                  context.watch<SearchGameProvider>().searchResult.length,
              itemBuilder: ((context, index) {
                print(
                  context.watch<SearchGameProvider>().searchResult[index]['id'],
                );
                print(
                  context.watch<SearchGameProvider>().searchResult[index]
                      ['name'],
                );
                print(
                  context.watch<SearchGameProvider>().searchResult[index]
                      ['gameplayMainExtra'],
                );
                print(
                  context.watch<SearchGameProvider>().searchResult[index]
                      ['imageUrl'],
                );

                return GameCard(
                  id: context.watch<SearchGameProvider>().searchResult[index]
                      ['id'],
                  name: context.watch<SearchGameProvider>().searchResult[index]
                      ['name'],
                  imageUrl: context
                      .watch<SearchGameProvider>()
                      .searchResult[index]['imageUrl'],
                  gameplayMain: context
                      .watch<SearchGameProvider>()
                      .searchResult[index]['gameplayMain']
                      .toString(),
                  gameplayMainExtra: context
                      .watch<SearchGameProvider>()
                      .searchResult[index]['gameplayMain']
                      .toString(),
                  gameplayCompletionist: context
                      .watch<SearchGameProvider>()
                      .searchResult[index]['id'],
                );
              })));
    }));
  }
}
