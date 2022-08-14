import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hltb/common/widgets/loading-anime.dart';
import 'package:hltb/project-variables.dart';
import 'package:hltb/providers/fav-scroller-provider.dart';
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
  var _indexForCount = 0;

  var fetchedTill = 0;
  int size = 8;

  bool loading = false;
  bool allLoaded = false;

  @override
  void initState() {
    super.initState();
    // if (this.mounted) {
    //   setState(() {
    //     fetchedTill = 0;
    //   });
    // }

    // if (this.mounted) {
    //   fetchedTill =
    //       Provider.of<FavScrollerProvider>(context, listen: false).fetchedTill;
    //   print(fetchedTill);
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (this.mounted) {
        fetchedTill = Provider.of<FavScrollerProvider>(context, listen: false)
            .fetchedTill;
        print(fetchedTill);
      }
    });

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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _indexForCount = 0;
  //   super.dispose();
  // }

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

    Provider.of<FavScrollerProvider>(context, listen: false)
        .changeFetchedTillCounter(fetchedTill + size);

    setState(() {
      fetchedTill = fetchedTill + size;
    });

    return result;
  }

  fetchPosts() async {
    // if (fetchedTill >=
    //     Provider.of<UserFavouriteGameProvider>(context, listen: false)
    //         .favGameDetails
    //         .length) {
    //   Provider.of<ShowOverlayLoaderProvider>(context, listen: false)
    //       .changeShowOverlayState(false);
    // }
    if (allLoaded) {
      return;
    } else {
      // Provider.of<ShowOverlayLoaderProvider>(context, listen: false)
      //     .changeShowOverlayState(true);
      setState(() {
        loading = true;
      });
    }

    var res = await apiCall();
    Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .addFavGameDetailToList(res);
    // Provider.of<ShowOverlayLoaderProvider>(context, listen: false)
    //     .changeShowOverlayState(false);
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
                Text(
                  'fetched till ---- ${fetchedTill}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'total : ${context.watch<UserFavouriteGameProvider>().userFavouriteGameList.length.toString()}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'fav game detail length ${context.watch<UserFavouriteGameProvider>().favGameDetails.length.toString()}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'favourites',
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

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (this.mounted) {
                                setState(() {
                                  _indexForCount = index;
                                });
                              }
                            });

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /*logic to fix when user adds a new game into fav list 
                                before fetching the fav games details*/
                                (context
                                            .watch<UserFavouriteGameProvider>()
                                            .favGameDetails[gameIds[index]] ==
                                        null)
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35),
                                        child: LoadingAnime(
                                            ProjectVariables.SEXY_WHITE),
                                      )
                                    : GameCard(
                                        id: context
                                            .watch<UserFavouriteGameProvider>()
                                            .favGameDetails[gameIds[index]]['id'],
                                        name: context
                                                .watch<UserFavouriteGameProvider>()
                                                .favGameDetails[gameIds[index]]
                                            ['name'],
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
                                        isWidgetFavPage: true,
                                      ),
                                (index + 1 ==
                                            context
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .favGameDetails
                                                .length &&
                                        _indexForCount + 1 <
                                            context
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .userFavouriteGameList
                                                .length)
                                    ? LoadingAnime(
                                        ProjectVariables.SEXY_WHITE,
                                        size: 50,
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
