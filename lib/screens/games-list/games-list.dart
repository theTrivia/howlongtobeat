import 'package:flutter/material.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/game-card/game-card.dart';
import 'package:provider/provider.dart';

class GamesList extends StatelessWidget {
  var searchResult = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: ((context, snapshot) {
      return Flexible(
          child: ListView.builder(
              itemCount:
                  context.watch<SearchGameProvider>().searchResult.length,
              itemBuilder: ((context, index) {
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
                      .searchResult[index]['gameplayMainExtra']
                      .toString(),
                  gameplayCompletionist: context
                      .watch<SearchGameProvider>()
                      .searchResult[index]['gameplayCompletionist']
                      .toString(),
                );
              })));
    }));
  }
}
