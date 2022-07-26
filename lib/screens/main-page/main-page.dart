import 'package:flutter/material.dart';
import 'package:hltb/common/input-field.dart';
import 'package:hltb/common/loading-anime.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/games-list/games-list.dart';
import 'package:hltb/screens/static-widgets/start-searching.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _didUserOpenAppNow = true;
  var _shouldWeLoadAnime = false;
  var _fetchingResultFinished = false;
  var _searchResultTerm = '';
  @override
  Widget build(BuildContext context) {
    var gameSearchEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          const Text(
            'howlongtobeat',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 72, 0, 255),
              fontWeight: FontWeight.w900,
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
                // TextFormField(
                //   controller: gameSearchEditingController,
                //   style: const TextStyle(
                //       color: Color.fromARGB(255, 72, 0, 255),
                //       fontWeight: FontWeight.bold),
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: const BorderSide(
                //         color: Color.fromARGB(255, 72, 0, 255),
                //       ),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: const BorderSide(
                //         color: Color.fromARGB(255, 72, 0, 255),
                //       ),
                //     ),
                //   ),
                // ),
                InputField(
                  hintText: 'Search...',
                  textEditingController: gameSearchEditingController,
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
          (_didUserOpenAppNow == true) ? StartSearching() : Container(),
          (_fetchingResultFinished == true)
              ? Text(
                  'Search Result for \'${_searchResultTerm}\'',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 72, 0, 255),
                    fontWeight: FontWeight.w900,
                  ),
                )
              : Container(),
          (_shouldWeLoadAnime == true) ? const LoadingAnime() : GamesList(),
        ],
      )),
    );
  }
}
