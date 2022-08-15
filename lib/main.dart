import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hltb/providers/fav-scroller-provider.dart';
import 'package:hltb/providers/popular-games-provider.dart';
import 'package:hltb/providers/show-overlaw-loader-provider.dart';
import './routes.dart';
import 'package:provider/provider.dart';

import './firebase_options.dart';

import '../providers/user-favourite-game-provider.dart';
import '../providers/search-game-provider.dart';
import '../screens/main-page/main-page.dart';
import '../screens/search-page/search-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SearchGameProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserFavouriteGameProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PopularGamesProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ShowOverlayLoaderProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FavScrollerProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/splashScreen',
        routes: routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: MainPage(),
        ));
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}
