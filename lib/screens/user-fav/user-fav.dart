import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hltb/common/widgets/loading-anime.dart';
import 'package:hltb/project-variables.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../private-creds.dart';
import '../../providers/search-game-provider.dart';
import '../../providers/show-overlaw-loader-provider.dart';
import '../../providers/user-favourite-game-provider.dart';
import '../game-card/game-card.dart';

class UserFav extends StatefulWidget {
  final ids;

  UserFav(this.ids, {Key? key}) : super(key: key);

  @override
  State<UserFav> createState() => _UserFavState();
}

class _UserFavState extends State<UserFav> {
  var favGames = [];
  var gameIds;

  @override
  void initState() {
    super.initState();
    gameIds = widget.ids;

    fetchPosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        fetchPosts();
      }
    });
  }

  int size = 8;

  bool loading = false;
  bool allLoaded = false;

  var fetchedTill = 0;

  final ScrollController _scrollController = ScrollController();

  apiCall() async {
    Map<String, dynamic> result = {};
    for (int i = fetchedTill; i < fetchedTill + size; i++) {
      try {
        var res = await http.get(
          Uri.parse(PrivateCreds.HELPER_SERVER +
              'gameDetail/' +
              gameIds[i].toString()),
        );
        var r = jsonDecode(res.body)['result'];
        // print(r);
        result[gameIds[i]] = r;
      } catch (e) {
        break;
      }
    }

    setState(() {
      fetchedTill = fetchedTill + size;
    });

    return result;
  }

  fetchPosts() async {
    if (allLoaded) {
      return;
    } else {
      setState(() {
        loading = true;
      });
    }

    var res = await apiCall();
    Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .addFavGameDetailToList(res);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:
          (context.watch<ShowOverlayLoaderProvider>().shouldShowOverlayLoader ==
                  false)
              ? () {
                  Navigator.pushNamed(context, '/mainPage');
                  return Future.value(true);
                }
              : () {
                  return Future.value(false);
                },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: ProjectVariables.BACKGROUND_GRADIENT,
          ),
          child: SafeArea(child: FutureBuilder(builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    context
                        .watch<ShowOverlayLoaderProvider>()
                        .shouldShowOverlayLoader
                        .toString(),
                    style: TextStyle(
                      fontSize: 30,
                      color: ProjectVariables.SEXY_WHITE,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                (context
                        .watch<UserFavouriteGameProvider>()
                        .favGameDetails
                        .isNotEmpty)
                    ? Flexible(
                        child: ListView.builder(
                          itemCount: context
                              .watch<UserFavouriteGameProvider>()
                              .favGameDetails
                              .length,
                          controller: _scrollController,
                          itemBuilder: ((context, index) {
                            var isGamePresentInFavList = true;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GameCard(
                                  id: context
                                      .watch<UserFavouriteGameProvider>()
                                      .favGameDetails[gameIds[index]]['id'],
                                  name: context
                                      .watch<UserFavouriteGameProvider>()
                                      .favGameDetails[gameIds[index]]['name'],
                                  imageUrl: context
                                          .watch<UserFavouriteGameProvider>()
                                          .favGameDetails[gameIds[index]]
                                      ['imageUrl'],
                                  gameplayMain: context
                                      .watch<UserFavouriteGameProvider>()
                                      .favGameDetails[gameIds[index]]
                                          ['gameplayMain']
                                      .toString(),
                                  gameplayMainExtra: context
                                      .watch<UserFavouriteGameProvider>()
                                      .favGameDetails[gameIds[index]]
                                          ['gameplayMainExtra']
                                      .toString(),
                                  gameplayCompletionist: context
                                      .watch<UserFavouriteGameProvider>()
                                      .favGameDetails[gameIds[index]]
                                          ['gameplayCompletionist']
                                      .toString(),
                                  isGameAddedInFavList: true,
                                ),
                                (index + 1 ==
                                            context
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .favGameDetails
                                                .length &&
                                        index <
                                            context
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .userFavouriteGameList
                                                .length)
                                    ? LoadingAnime(
                                        ProjectVariables.SEXY_WHITE,
                                      )
                                    : Container(),
                              ],
                            );
                          }),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.35),
                        child: LoadingAnime(ProjectVariables.SEXY_WHITE),
                      ),
              ],
            );
          }
                  // }));
                  )
              // ),
              ),
        ),
      ),
    );
  }
}
