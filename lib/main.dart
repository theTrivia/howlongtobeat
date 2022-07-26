import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hltb/firebase_options.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/landing-page/landing-page.dart';
import 'package:hltb/screens/login/login.dart';
import 'package:hltb/screens/signup/signup.dart';
import 'package:provider/provider.dart';
import 'package:hltb/screens/main-page/main-page.dart';

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
        create: (_) => SearchGameProvider(),
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
        initialRoute: '/login',
        routes: {
          // "/": (context) => LandingPage(),
          "/login": (context) => Login(),
          "/signup": (context) => Signup(),
          "/appMainPage": (context) => MainPage(),
          // "/addPassword": (context) => AddPasswd(),
          // "/settings": (context) => AppSettings(),
          // "/aboutUs": (context) => AboutUs(),
          // "/editMasterPassword": (context) => EditMasterPassword(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Login(),
        ));
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
