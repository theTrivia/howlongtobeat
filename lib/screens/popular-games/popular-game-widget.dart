import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/popular-games-provider.dart';
import '../../providers/search-game-provider.dart';
import '../../providers/user-favourite-game-provider.dart';
import '../game-detail/game-detail.dart';

class PopularGameWidget extends StatelessWidget {
  final int index;
  PopularGameWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<UserFavouriteGameProvider>(context, listen: false)
          .fetchFavouriteGameDetails(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var gameId =
            context.watch<PopularGamesProvider>().popularGames[index]['gameId'];
        var isGamePresentInFavList;

        if (context
            .watch<UserFavouriteGameProvider>()
            .userFavouriteGameList
            .contains(gameId)) {
          isGamePresentInFavList = true;
        } else {
          isGamePresentInFavList = false;
        }
        return GestureDetector(
          onTap: () {
            print(gameId);
            print(isGamePresentInFavList);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GameDetail(gameId, isGamePresentInFavList),
              ),
            );
          },
          child: SizedBox(
            // padding: const EdgeInsets.all(8),
            child: SizedBox.fromSize(
              child: Image.network(
                'https://howlongtobeat.com' +
                    context.watch<PopularGamesProvider>().popularGames[index]
                        ['image'],
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
