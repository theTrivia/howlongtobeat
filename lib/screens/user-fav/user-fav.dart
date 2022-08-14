import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hltb/common/widgets/loading-anime.dart';
import 'package:hltb/project-variables.dart';
import 'package:hltb/providers/fav-scroller-provider.dart';
import 'package:hltb/screens/user-fav/empty-fav-list.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../private-creds.dart';
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
  bool _isUserListEmpty = false;
  var favGames = [];
  var gameIds;
  var _indexForCount = 0;

  var fetchedTill = 0;
  int size = 8;

  bool loading = false;
  bool allLoaded = false;

  bool _shouldLoadBigLoaderProgrammatically = false;

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
                            .userFavouriteGameList
                            .length ==
                        0)
                    ? const EmptyFavList()
                    : (context
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
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // if (Provider.of<UserFavouriteGameProvider>(
                                  //             context,
                                  //             listen: false)
                                  //         .favGameDetails[gameIds[index]] ==
                                  //     null) {
                                  //   setState(() {
                                  //     _shouldLoadBigLoaderProgrammatically
                                  // = true;
                                  //   });
                                  // }
                                  // if (index > 0) {
                                  //   setState(() {
                                  //     _shouldLoadBigLoaderProgrammatically
                                  // = false;
                                  //   });
                                  // }
                                  if (this.mounted) {
                                    if (Provider.of<UserFavouriteGameProvider>(
                                                context,
                                                listen: false)
                                            .favGameDetails[gameIds[index]] ==
                                        null) {
                                      setState(() {
                                        _shouldLoadBigLoaderProgrammatically =
                                            true;
                                      });
                                    }
                                    if (index > 0) {
                                      setState(() {
                                        _shouldLoadBigLoaderProgrammatically =
                                            false;
                                      });
                                    }
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
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .favGameDetails[gameIds[index]] ==
                                            null)
                                        // ? Padding(
                                        //     padding: EdgeInsets.only(
                                        //         top: MediaQuery.of(context)
                                        //                 .size
                                        //                 .height *
                                        //             0.35),
                                        //     child: LoadingAnime(
                                        //       ProjectVariables.SEXY_WHITE,
                                        //     ),
                                        //   )
                                        ? Container()
                                        : GameCard(
                                            id: context
                                                    .watch<
                                                        UserFavouriteGameProvider>()
                                                    .favGameDetails[
                                                gameIds[index]]['id'],
                                            name: context
                                                    .watch<
                                                        UserFavouriteGameProvider>()
                                                    .favGameDetails[
                                                gameIds[index]]['name'],
                                            imageUrl: context
                                                    .watch<
                                                        UserFavouriteGameProvider>()
                                                    .favGameDetails[
                                                gameIds[index]]['imageUrl'],
                                            gameplayMain: context
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .favGameDetails[gameIds[index]]
                                                    ['gameplayMain']
                                                .toString(),
                                            gameplayMainExtra: context
                                                .watch<
                                                    UserFavouriteGameProvider>()
                                                .favGameDetails[gameIds[index]]
                                                    ['gameplayMainExtra']
                                                .toString(),
                                            gameplayCompletionist: context
                                                .watch<
                                                    UserFavouriteGameProvider>()
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
                                        // ? LoadingAnime(
                                        //     ProjectVariables.SEXY_WHITE,
                                        //     size: 50,
                                        //   )
                                        ? Container()
                                        : Container(),
                                  ],
                                );
                              }),
                            ),
                          )
                        // : Padding(
                        //     padding: EdgeInsets.only(
                        //         top: MediaQuery.of(context).size.height * 0.35),
                        //     child: LoadingAnime(ProjectVariables.SEXY_WHITE),
                        //   ),
                        : Container(),
                (loading == true &&
                        _indexForCount > 1 &&
                        _indexForCount <
                            context
                                .watch<UserFavouriteGameProvider>()
                                .userFavouriteGameList
                                .length)
                    ? LoadingAnime(
                        ProjectVariables.SEXY_WHITE,
                        size: 50,
                      )
                    : Container(),
                // (_shouldLoadBigLoaderProgrammatically
                // == true)
                //     ? Container(
                //         margin: EdgeInsets.only(
                //             top: MediaQuery.of(context).size.height * 0.5),
                //         child: LoadingAnime(
                //           ProjectVariables.SEXY_WHITE,
                //         ),
                //       )
                //     : Container(),
                (_shouldLoadBigLoaderProgrammatically == true)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnime(
                              ProjectVariables.SEXY_WHITE,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                // (fetchedTill < size && _shouldLoadBigLoaderProgrammatically
                // == false)
                //     ? Container(
                //         child: LoadingAnime(ProjectVariables.SEXY_WHITE),
                //         margin: EdgeInsets.only(
                //             bottom: MediaQuery.of(context).size.height * 0.5),
                //       )
                //     : Container()
                (fetchedTill < size &&
                        _shouldLoadBigLoaderProgrammatically == false)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnime(
                              ProjectVariables.SEXY_WHITE,
                            ),
                          ],
                        ),
                      )
                    : Container(),
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
