import 'package:flutter/material.dart';
import '../../providers/popular-games-provider.dart';
import './popular-game-widget.dart';
import 'package:provider/provider.dart';

import '../game-detail/game-detail.dart';

class PopularGames extends StatelessWidget {
  const PopularGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(left: 10, right: 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: <Widget>[
          PopularGameWidget(0),
          PopularGameWidget(1),
          PopularGameWidget(2),
          PopularGameWidget(3),
          PopularGameWidget(4),
          PopularGameWidget(5),
        ],
      ),
    );
  }
}
