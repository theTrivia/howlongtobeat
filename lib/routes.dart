import 'package:flutter/material.dart';

import '../screens/popular-games/popular-games-page.dart';
import '../screens/splash-screen/splash-screen.dart';
import '../screens/login/login.dart';
import '../screens/main-page/main-page.dart';
import '../screens/search-page/search-page.dart';
import '../screens/signup/signup.dart';

var routes = <String, WidgetBuilder>{
  "/splashScreen": (context) => SplashScreen(),
  "/mainPage": (context) => const MainPage(),
  "/login": (context) => Login(),
  "/signup": (context) => Signup(),
  "/appMainPage": (context) => SearchPage(),
  "/popularGamesPage": (context) => const PopularGamesPage(),
  // "/userFav": (context) => UserFav(),
};
