import 'package:flutter/material.dart';
import 'package:hltb/project-variables.dart';
import 'package:provider/provider.dart';

import '../../providers/search-game-provider.dart';
import '../../providers/user-favourite-game-provider.dart';
import '../game-card/game-card.dart';

class UserFav extends StatelessWidget {
  const UserFav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/mainPage');
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(100),
            // image: DecorationImage(
            //   image: NetworkImage(
            //       'https://s3.envato.com/files/16cdea6b-a392-482a-905c-541e480bc1ce/inline_image_preview.jpg'),
            //   fit: BoxFit.fill,
            // ),
            gradient: ProjectVariables.BACKGROUND_GRADIENT,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'favourites',
                    style: TextStyle(
                      fontSize: 25,
                      color: ProjectVariables.SEXY_WHITE,
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
        ),
      ),
    );
  }
}
