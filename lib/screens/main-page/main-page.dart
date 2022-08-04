import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
  static List<Widget> _widgetOptions = [
    SearchPage(),
    UserFav(),
  ];

  //fetching user favourite games... [Needs to be refactored]
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<UserFavouriteGameProvider>(context, listen: false)
  //       .fetchFavouriteGameDetails();
  // }

  void _onItemTapped(index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedindex),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          backgroundColor: ProjectVariables.SEXY_WHITE,
          selectedItemColor: ProjectVariables.MAIN_COLOR,
          // fixedColor: Colo,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            )
          ],
          currentIndex: _selectedindex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
