import 'package:flutter/material.dart';
import 'package:hltb/providers/user-favourite-game-provider.dart';
import 'package:hltb/screens/user-fav/helper-function.dart';
import 'package:provider/provider.dart';

import '../../providers/search-game-provider.dart';
import '../game-card/game-card.dart';

class UserFav extends StatelessWidget {
  const UserFav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'favourites',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 72, 0, 255),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder(
                builder: ((context, snapshot) {
                  return ListView.builder(
                    itemCount: context
                        .watch<UserFavouriteGameProvider>()
                        .favGameDetails
                        .length,
                    itemBuilder: ((context, index) {
                      var isGamePresentInFavList = true;

                      return GameCard(
                        id: context
                            .watch<UserFavouriteGameProvider>()
                            .favGameDetails[index]['id'],
                        name: context
                            .watch<UserFavouriteGameProvider>()
                            .favGameDetails[index]['name'],
                        imageUrl: context
                            .watch<UserFavouriteGameProvider>()
                            .favGameDetails[index]['imageUrl'],
                        gameplayMain: context
                            .watch<UserFavouriteGameProvider>()
                            .favGameDetails[index]['gameplayMain']
                            .toString(),
                        gameplayMainExtra: context
                            .watch<UserFavouriteGameProvider>()
                            .favGameDetails[index]['gameplayMainExtra']
                            .toString(),
                        gameplayCompletionist: context
                            .watch<UserFavouriteGameProvider>()
                            .favGameDetails[index]['gameplayCompletionist']
                            .toString(),
                        isGameAddedInFavList: isGamePresentInFavList,
                      );
                    }),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
