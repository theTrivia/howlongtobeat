import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hltb/screens/game-detail/game-detail.dart';
import 'package:hltb/project-variables.dart';

import '../../common/play-time-board.dart';
import './helper-function.dart';

class GameCard extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String gameplayMain;
  final String gameplayMainExtra;
  final String gameplayCompletionist;
  final bool isGameAddedInFavList;

  GameCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.gameplayMain,
    required this.gameplayMainExtra,
    required this.gameplayCompletionist,
    required this.isGameAddedInFavList,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  var _isIconButtonClicked = false;

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
            color: ProjectVariables.BACKGROUND_COLOR,
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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          PlayTimeBoard(
                            gameplayMain: widget.gameplayMain,
                            gameplayMainExtra: widget.gameplayMainExtra,
                            gameplayCompletionist: widget.gameplayCompletionist,
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
                      onFavIconPress(widget.id, context);
                      setState(() {
                        _isIconButtonClicked = true;
                      });
                    },
                    icon: (widget.isGameAddedInFavList == true)
                        ? Icon(FontAwesomeIcons.heartCrack)
                        : Icon(FontAwesomeIcons.solidHeart),
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
