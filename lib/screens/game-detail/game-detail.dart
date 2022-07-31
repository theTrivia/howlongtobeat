import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hltb/common/loading-anime.dart';
import 'package:hltb/common/play-time-board.dart';
import 'package:hltb/project-variables.dart';
import 'package:hltb/screens/game-detail/youtube-test.dart';
import 'package:http/http.dart' as http;

import '../../model/youtube-video.dart';

class GameDetail extends StatefulWidget {
  final String gameId;
  GameDetail(this.gameId, {Key? key}) : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  var gameDetail;
  var shouldWeLoad = true;
  var ytVideo = null;
  var _ytVideoReceived = false;
  getGameDetail(gameId) async {
    try {
      var result = await http
          .get(Uri.parse('http://192.168.0.182:3000/gameDetail/' + gameId));
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
    getGameDetail(widget.gameId).then((res) {
      fetchYoutubeVideoLink(res['name']).then((res) {
        var video = YoutubeVideo(
          res.channelId,
          res.channelTitle,
          res.channelUrl,
          res.description,
          res.duration,
          res.id,
          res.kind,
          res.publishedAt,
          res.thumbnail,
          res.title,
          res.url,
        );

        setState(() {
          ytVideo = video;
          _ytVideoReceived = true;
        });
      });

      setState(() {
        gameDetail = res;
        shouldWeLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // backgroundColor: ProjectVariables.BACKGROUND_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: (gameDetail == null)
              ? const LoadingAnime()
              : Column(
                  children: [
                    Text(
                      gameDetail['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 72, 0, 255),
                        fontWeight: FontWeight.w900,
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
                              Image.network(
                                'https://howlongtobeat.com' +
                                    gameDetail['imageUrl'],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'How long to beat?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 0, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PlayTimeBoard(
                            gameplayMain: gameDetail['gameplayMain'].toString(),
                            gameplayMainExtra:
                                gameDetail['gameplayMainExtra'].toString(),
                            gameplayCompletionist:
                                gameDetail['gameplayCompletionist'].toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 0, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            gameDetail['description'],
                            style: TextStyle(
                              // color: Colors.white,
                              color: ProjectVariables.INPUT_TEXT_COLOR_2,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Playable On',
                            style: TextStyle(
                              color: Color.fromARGB(255, 72, 0, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (gameDetail['playableOn'].length > 0)
                                ? gameDetail['playableOn'].toString().substring(
                                      1,
                                      gameDetail['playableOn']
                                              .toString()
                                              .length -
                                          1,
                                    )
                                : 'Not Available',
                            style: TextStyle(
                              // color: Colors.white,
                              color: ProjectVariables.INPUT_TEXT_COLOR_2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
