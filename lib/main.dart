import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hltb/providers/popular-games-provider.dart';
import 'package:provider/provider.dart';

import './firebase_options.dart';

import '../providers/user-favourite-game-provider.dart';
import '../providers/search-game-provider.dart';
import '../screens/splash-screen/splash-screen.dart';
import '../screens/main-page/main-page.dart';
import '../screens/login/login.dart';
import '../screens/search-page/search-page.dart';
import '../screens/signup/signup.dart';
import '../screens/user-fav/user-fav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    ],
    child: MyApp(),
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
        routes: {
          // "/": (context) => LandingPage(),
          "/splashScreen": (context) => SplashScreen(),
          "/mainPage": (context) => MainPage(),
          "/login": (context) => Login(),
          "/signup": (context) => Signup(),
          "/appMainPage": (context) => SearchPage(),
          "/userFav": (context) => UserFav(),

          // "/addPassword": (context) => AddPasswd(),
          // "/settings": (context) => AppSettings(),
          // "/aboutUs": (context) => AboutUs(),
          // "/editMasterPassword": (context) => EditMasterPassword(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          // backgroundColor: Colors.black,
          body: MainPage(),
        ));
  }
}

// class BottomNavigationBarImpl extends StatelessWidget {
//   const BottomNavigationBarImpl({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favourites',
//           )
//         ],
//       ),
//     );
//   }
// }

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}
