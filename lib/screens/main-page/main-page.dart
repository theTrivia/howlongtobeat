import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../providers/show-overlaw-loader-provider.dart';
import '../../providers/user-favourite-game-provider.dart';
import '../../project-variables.dart';
import '../search-page/search-page.dart';
import '../user-fav/user-fav.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _selectedindex = 0;

  void _onItemTapped(index) {
    // if (context.watch<ShowOverlayLoaderProvider>().shouldShowOverlayLoader ==
    //     false) {
    //   setState(() {
    //     _selectedindex = index;
    //   });
    // } else {
    //   setState(() {
    //     _selectedindex = _selectedindex;
    //   });
    // }
    setState(() {
      _selectedindex = index;
    });
  }

  //method to handle when game data is still being added.
  _bogus(index) {
    setState(() {
      _selectedindex = _selectedindex;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      SearchPage(),
      UserFav(context.watch<UserFavouriteGameProvider>().userFavouriteGameList),
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedindex),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          backgroundColor: ProjectVariables.SEXY_WHITE,
          selectedItemColor: ProjectVariables.MAIN_COLOR,
          // fixedColor: Colo,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidHeart),
              label: 'Favourites',
            )
          ],
          currentIndex: _selectedindex,
          onTap: (context
                      .watch<ShowOverlayLoaderProvider>()
                      .shouldShowOverlayLoader ==
                  false)
              ? _onItemTapped
              : _bogus,
        ),
      ),
    );
  }
}
