import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hltb/private-creds.dart';
import 'package:hltb/providers/show-overlaw-loader-provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './metascore.dart';
import '../../common/widgets/loading-anime.dart';
import '../../common/widgets/play-time-board.dart';
import '../../project-variables.dart';
import './youtube-test.dart';
import '../../common/functions/on-fav-icon-pressed.dart';
import '../../model/youtube-video.dart';
import './helper-function.dart';

class GameDetail extends StatefulWidget {
  final String gameId;
  final bool isGameAddedInFavList;
  GameDetail(this.gameId, this.isGameAddedInFavList, {Key? key})
      : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  var gameDetail;
  var shouldWeLoad = true;
  var ytVideo = null;
  var _ytVideoReceived = false;
  var _useMetacriticForGameDetails = true;
  var _metacriticGameDetail = '';
  var _metascore = '';
  var _isIconButtonClicked = false;
  var _savingData = false;

  // 0 == !fav , 1 == fav
  var _favIcon = 0;
  getGameDetail(gameId) async {
    try {
      var result = await http
          .get(Uri.parse(PrivateCreds.HLTB_SERVER + 'gameDetail/' + gameId));
      // print(result.body);
      var formattedResult = jsonDecode(result.body)['result'];
      return formattedResult;
    } catch (e) {
      print(e);
    }
  }

  fetchYoutubeVideoLink(gameName) async {
    // var videoResult = await YoutubeTest.fetchVideo(gameName).then((res) {
    //   ytVideo = YoutubeVideo(
    //       res.channelId,
    //       res.channelTitle,
    //       res.channelUrl,
    //       res.description,
    //       res.duration,
    //       res.id,
    //       res.kind,
    //       res.publishedAt,
    //       res.thumbnail,
    //       res.title,
    //       res.url);
    // });
    var videoResult = await YoutubeTest.fetchVideo(gameName);
    return videoResult;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isGameAddedInFavList == true) {
      _favIcon = 1;
    } else {
      _favIcon = 0;
    }
    // print(_favIcon);
    getGameDetail(widget.gameId).then((res) async {
      // print(res);
      final videoGameName = res['name'];

      //clean game name
      final cleanedGameName = cleanGameNameForMetacritic(videoGameName);
      final uniformPlatform = unifyPlatformForMetacritic(res['playableOn']);
      if (uniformPlatform == '') {
        _useMetacriticForGameDetails = false;
      }
      //fetch game detail from metacritic-game-detail-helper-function
      // await http
      //     .get(Uri.parse(ProjectVariables.METACRITIC_GAME_DETAIL_SERVER +
      //         'gameDetail/' +
      //         uniformPlatform +
      //         '/' +
      //         cleanedGameName))

      await fetchGameDetailFromMetcriticBackendServer(
              uniformPlatform, cleanedGameName)
          .then((res) {
        try {
          print(res);
          if (res == [] || jsonDecode(res.body)['game-detail'] == "Not Found") {
            setState(() {
              _useMetacriticForGameDetails = false;
            });
          } else {
            setState(() {
              _metacriticGameDetail = jsonDecode(res.body)['game-detail'];
            });
          }
        } catch (e) {
          setState(() {
            _useMetacriticForGameDetails = false;
          });
        }

        // print(res.body);
      });

      await fetchMetascoreFromMetacriticBackendServer(
              uniformPlatform, cleanedGameName)
          .then((metascore) {
        setState(() {
          _metascore = metascore;
        });
        // print(metascore);
      });

      //Logic for fetching yt video link
      // fetchYoutubeVideoLink(res['name']).then((res) {
      //   var video = YoutubeVideo(
      //     res.channelId,
      //     res.channelTitle,
      //     res.channelUrl,
      //     res.description,
      //     res.duration,
      //     res.id,
      //     res.kind,
      //     res.publishedAt,
      //     res.thumbnail,
      //     res.title,
      //     res.url,
      //   );

      //   setState(() {
      //     ytVideo = video;
      //     _ytVideoReceived = true;
      //   });
      // });

      setState(() {
        gameDetail = res;
        shouldWeLoad = false;
      });
      print(gameDetail['name']);
    });
  }

  abc() {
    print('hello');
    print(context
        .watch<ShowOverlayLoaderProvider>()
        .shouldShowOverlayLoader
        .toString());
    if (context.watch<ShowOverlayLoaderProvider>().shouldShowOverlayLoader ==
        false) {
      return Future.value(false);
    } else {
      Navigator.pop(context);
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (_savingData == true) {
        //   return Future.value(false);
        // } else {
        //   Navigator.pop(context);
        //   return Future.value(true);
        // }
        print(
            context.watch<ShowOverlayLoaderProvider>().shouldShowOverlayLoader);
        if (context
                .watch<ShowOverlayLoaderProvider>()
                .shouldShowOverlayLoader ==
            false) {
          return Future.value(true);
        } else {
          Navigator.pushNamed(context, '/mainPage');
          return Future.value(false);
        }
      },
      child: Scaffold(
        // backgroundColor: ProjectVariables.BACKGROUND_COLOR,
        body: Container(
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(100),
            image: (gameDetail == null)
                ? DecorationImage(
                    image: NetworkImage(
                        'https://s3.envato.com/files/16cdea6b-a392-482a-905c-541e480bc1ce/inline_image_preview.jpg'),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage(
                      'https://howlongtobeat.com' + gameDetail['imageUrl'],
                    ),
                    fit: BoxFit.fill,

                    // opacity: 0.2,
                  ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: (gameDetail == null)
                      ? LoadingAnime(ProjectVariables.MAIN_COLOR)
                      : Column(
                          children: [
                            // Text(
                            //   _savingData.toString(),
                            //   style:
                            //       TextStyle(color: Colors.white, fontSize: 20),
                            // ),
                            Text(
                              context
                                  .watch<ShowOverlayLoaderProvider>()
                                  .shouldShowOverlayLoader
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),

                            FittedBox(
                              child: Text(
                                gameDetail['name'],
                                // 'sss',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.staatliches(
                                  color: ProjectVariables.SEXY_WHITE,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          'https://howlongtobeat.com' +
                                              gameDetail['imageUrl'],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: (_metascore == 'Not Found')
                                            ? Container()
                                            : Metascore(ms: _metascore),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        color: ProjectVariables.MAIN_COLOR_DARK,
                                        child: IconButton(
                                          onPressed: () {
                                            // setState(() {
                                            //   _savingData = true;
                                            // });
                                            if (_favIcon == 0) {
                                              print(_favIcon);
                                              setState(() {
                                                _favIcon = 1;
                                              });
                                            } else if (_favIcon == 1) {
                                              print(_favIcon);
                                              setState(() {
                                                _favIcon = 0;
                                              });
                                            }
                                            onFavIconPress(
                                                widget.gameId, context);
                                            //     .then((_) {
                                            //   setState(() {
                                            //     _savingData = false;
                                            //   });
                                            // });

                                            // setState(() {
                                            //   _isIconButtonClicked = true;
                                            // });
                                          },
                                          icon: (_favIcon == 0)
                                              ? Icon(
                                                  FontAwesomeIcons.solidHeart,
                                                  color: ProjectVariables
                                                      .SEXY_WHITE,
                                                )
                                              : Icon(
                                                  FontAwesomeIcons.heartCrack,
                                                  color: ProjectVariables
                                                      .SEXY_WHITE,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'How long to beat?',
                                    style: GoogleFonts.staatliches(
                                      color: ProjectVariables.SEXY_WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  PlayTimeBoard(
                                    gameplayMain:
                                        gameDetail['gameplayMain'].toString(),
                                    gameplayMainExtra:
                                        gameDetail['gameplayMainExtra']
                                            .toString(),
                                    gameplayCompletionist:
                                        gameDetail['gameplayCompletionist']
                                            .toString(),
                                    cardHeight: 25,
                                    circularBorderRadius: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Description',
                                    style: GoogleFonts.staatliches(
                                      color: ProjectVariables.SEXY_WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    (_useMetacriticForGameDetails == false)
                                        ? gameDetail['description']
                                        : _metacriticGameDetail,
                                    // style: TextStyle(
                                    //   // color: Colors.white,
                                    //   // color: ProjectVariables.INPUT_TEXT_COLOR_2,
                                    //   color: ProjectVariables.SEXY_WHITE,
                                    // ),
                                    style: GoogleFonts.barlowCondensed(
                                      color: ProjectVariables.SEXY_WHITE,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    (_useMetacriticForGameDetails == false)
                                        ? ''
                                        : 'Powered By Metacritic',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(111, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Playable On',
                                    style: GoogleFonts.staatliches(
                                      color: ProjectVariables.SEXY_WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    (gameDetail['playableOn'].length > 0)
                                        ? gameDetail['playableOn']
                                            .toString()
                                            .substring(
                                              1,
                                              gameDetail['playableOn']
                                                      .toString()
                                                      .length -
                                                  1,
                                            )
                                        : 'Not Available',
                                    style: GoogleFonts.barlowCondensed(
                                      color: ProjectVariables.SEXY_WHITE,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
