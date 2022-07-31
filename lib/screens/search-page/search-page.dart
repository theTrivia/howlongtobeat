import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hltb/common/input-field.dart';
import 'package:hltb/common/loading-anime.dart';
import 'package:hltb/methods/logout.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/games-list/games-list.dart';
import 'package:hltb/screens/static-widgets/start-searching.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../project-variables.dart';

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
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: SafeArea(
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
                    const Text(
                      'howlongtobeat',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 72, 0, 255),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: ProjectVariables.MAIN_COLOR,
                      ),
                      onPressed: () async {
                        await Logout.onLogout(context);
                        Navigator.pushNamed(context, '/splashScreen');
                      },
                    )
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
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    InputField(
                      hintText: 'Search...',
                      textEditingController: gameSearchEditingController,
                      borderColor: ProjectVariables.BORDER_COLOR_2,
                      focusedBorderColor:
                          ProjectVariables.FOCUSED_BORDER_COLOR_2,
                      hintTextColor: ProjectVariables.HINT_TEXT_COLOR_2,
                      inputTextColor: ProjectVariables.INPUT_TEXT_COLOR_2,
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          _shouldWeLoadAnime = true;
                          _searchResultTerm = gameSearchEditingController.text;
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
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 72, 0, 255),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              (_didUserOpenAppNow == true &&
                      context.watch<SearchGameProvider>().searchResult.length ==
                          0)
                  ? StartSearching()
                  : Container(),
              (_fetchingResultFinished == true)
                  ? Text(
                      'Search Result for \'${_searchResultTerm}\'',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 72, 0, 255),
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Container(),
              (_shouldWeLoadAnime == true)
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      // color: Colors.red,
                      child: const LoadingAnime(),
                    )
                  : GamesList(),
            ],
          ),
        ),
      ),
    );
  }
}
