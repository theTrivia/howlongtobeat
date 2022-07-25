import 'package:flutter/material.dart';
import 'package:hltb/providers/search-game-provider.dart';
import 'package:hltb/screens/landing-page/landing-page.dart';
import 'package:provider/provider.dart';
import 'package:hltb/screens/main-page/main-page.dart';

void main() {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMaterialApp(),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingPage(),
    );
  }
}
