import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hltb/screens/popular-games/popular-games.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../common/widgets/input-field.dart';
import '../../common/widgets/loading-anime.dart';
import '../../project-variables.dart';
import '../../providers/search-game-provider.dart';
import '../../providers/show-overlaw-loader-provider.dart';
import '../games-list/games-list.dart';
import '../../common/widgets/logout-button.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _didUserOpenAppNow = true;

  var _shouldWeLoadAnime = false;

  var _fetchingResultFinished = false;

  var _searchResultTerm = '';

  @override
  Widget build(BuildContext context) {
    var gameSearchEditingController = TextEditingController();
    return WillPopScope(
      // onWillPop: () {
      //   exit(0);
      // },
      onWillPop:
          (context.watch<ShowOverlayLoaderProvider>().shouldShowOverlayLoader ==
                  false)
              ? () {
                  exit(0);
                }
              : () {
                  return Future.value(false);
                },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(100),
            gradient: ProjectVariables.BACKGROUND_GRADIENT,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'howlongtobeat',
                        // style:
                        // fontSize: 25,
                        // color: Color.fromARGB(255, 72, 0, 255),
                        // fontWeight: FontWeight.w900,
                        style: GoogleFonts.staatliches(
                          color: ProjectVariables.MAIN_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      const LogoutButton(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      InputField(
                        hintText: 'Search...',
                        textEditingController: gameSearchEditingController,
                        borderColor: ProjectVariables.SEXY_WHITE,
                        focusedBorderColor: ProjectVariables.SEXY_WHITE,
                        hintTextColor: ProjectVariables.SEXY_WHITE,
                        inputTextColor: ProjectVariables.SEXY_WHITE,
                        obscureText: false,
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            _shouldWeLoadAnime = true;
                            _searchResultTerm =
                                gameSearchEditingController.text;
                            _didUserOpenAppNow = false;
                          });
                          await Provider.of<SearchGameProvider>(context,
                                  listen: false)
                              .searchGames(gameSearchEditingController.text);
                          setState(() {
                            _shouldWeLoadAnime = false;
                            _fetchingResultFinished = true;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: ProjectVariables.SEXY_WHITE,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (_didUserOpenAppNow == true &&
                        context
                                .watch<SearchGameProvider>()
                                .searchResult
                                .length ==
                            0)
                    ? Column(
                        children: [
                          Text(
                            'Popular Games',
                            style: GoogleFonts.staatliches(
                              color: ProjectVariables.SEXY_WHITE,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : Container(),
                (_didUserOpenAppNow == true &&
                        context
                                .watch<SearchGameProvider>()
                                .searchResult
                                .length ==
                            0)
                    // ? StartSearching()
                    ? PopularGames()
                    : Container(),
                (_fetchingResultFinished == true)
                    ? Text(
                        'Search Result for \'${_searchResultTerm}\'',
                        // style: TextStyle(
                        //   color: ProjectVariables.SEXY_WHITE,
                        //   fontWeight: FontWeight.w900,

                        // ),
                        style: GoogleFonts.staatliches(
                          color: ProjectVariables.MAIN_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : Container(),
                (_shouldWeLoadAnime == true)
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        // color: Colors.red,
                        child: LoadingAnime(ProjectVariables.MAIN_COLOR),
                      )
                    : GamesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
