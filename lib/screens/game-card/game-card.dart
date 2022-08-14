import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hltb/providers/show-overlaw-loader-provider.dart';
import 'package:provider/provider.dart';

import '../../common/functions/on-fav-icon-pressed.dart';
import '../../common/widgets/play-time-board.dart';
import '../../project-variables.dart';
import '../../providers/user-favourite-game-provider.dart';
import '../game-detail/game-detail.dart';

class GameCard extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String gameplayMain;
  final String gameplayMainExtra;
  final String gameplayCompletionist;
  final bool isGameAddedInFavList;

  //variable to encounter if the widget is FavPage. If the widget is so then, default icon will be FontAwesomeIcons.heartCrack.
  var isWidgetFavPage;

  GameCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.gameplayMain,
    required this.gameplayMainExtra,
    required this.gameplayCompletionist,
    required this.isGameAddedInFavList,
    this.isWidgetFavPage: false,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  var _isIconButtonClicked = false;
  // 0 == !fav , 1 == fav
  var _favIcon = 0;

  doAsyncJob() async {
    // await Provider.of<UserFavouriteGameProvider>(context, listen: false)
    //     .fetchFavouriteGameDetails();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doAsyncJob();
    if (widget.isGameAddedInFavList == true) {
      _favIcon = 1;
    } else {
      _favIcon = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GameDetail(widget.id, widget.isGameAddedInFavList),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            color: ProjectVariables.SEXY_WHITE_LOW,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(40), // Image radius
                      child: Image.network(
                        'https://howlongtobeat.com' + widget.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Text(
                              (widget.name.length > 18)
                                  ? '${widget.name.substring(0, 18)}...'
                                  : widget.name,
                              style: GoogleFonts.staatliches(
                                color: ProjectVariables.MAIN_COLOR_DARK,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          PlayTimeBoard(
                            gameplayMain: widget.gameplayMain,
                            gameplayMainExtra: widget.gameplayMainExtra,
                            gameplayCompletionist: widget.gameplayCompletionist,
                            cardHeight: 17,
                            circularBorderRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: ProjectVariables.MAIN_COLOR_DARK,
                  height: 100,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      //snackbar code needs to be refactored.
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: ProjectVariables.MAIN_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: Container(
                            color: ProjectVariables.MAIN_COLOR,
                            child: Text(
                              'Saving',
                              style: GoogleFonts.barlowCondensed(
                                color: ProjectVariables.SEXY_WHITE,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          )));

                      // if (context
                      //         .watch<ShowOverlayLoaderProvider>()
                      //         .shouldShowOverlayLoader ==
                      //     true)
                      if (Provider.of<ShowOverlayLoaderProvider>(context,
                                  listen: false)
                              .shouldShowOverlayLoader ==
                          true) {
                        print('cannot perform action as some process is going');
                        return;
                      } else {
                        onFavIconPress(widget.id, context);
                      }

                      setState(() {
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
                      });
                      // Provider.of<ShowOverlayLoaderProvider>(context,
                      //         listen: false)
                      //     .changeShowOverlayState(false);
                    },
                    // icon: (_favIcon == 0)
                    //     ? const Icon(
                    //         FontAwesomeIcons.solidHeart,
                    //         color: Colors.white,
                    //       )
                    //     : const Icon(
                    //         FontAwesomeIcons.heartCrack,
                    //         color: Colors.white,
                    //       ),
                    icon: (_favIcon != 0 || widget.isWidgetFavPage == true)
                        ? const Icon(
                            FontAwesomeIcons.heartCrack,
                            color: Colors.white,
                          )
                        : const Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.white,
                          ),
                    color: Colors.white,
                    iconSize: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
