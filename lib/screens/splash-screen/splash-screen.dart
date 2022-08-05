import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hltb/providers/popular-games-provider.dart';
import 'package:provider/provider.dart';

import '../../project-variables.dart';
import '../../providers/user-favourite-game-provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<SplashScreen> {
  final secureStorage = const FlutterSecureStorage();
  var _userShouldLoginOrSignup = false;

  doAsyncJob(context) async {
    await Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .fetchFavouriteGameDetails();

    await Provider.of<PopularGamesProvider>(context, listen: false)
        .getPopularGames();
  }

  // fetchPopularGames() async {
  //   await Provider.of<PopularGamesProvider>(context, listen: false)
  //       .getPopularGames();
  // }

  @override
  void initState() {
    super.initState();

    secureStorage.read(key: 'uid').then((uid) {
      if (uid == null) {
        setState(() {
          _userShouldLoginOrSignup = true;
        });
      } else {
        doAsyncJob(context).then((_) async {
          Navigator.pushNamed(context, '/mainPage');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // exit(0) is not recommended though.
        exit(0);
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 72, 0, 255),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'howlongtobeat',
                style: GoogleFonts.staatliches(
                  color: ProjectVariables.SEXY_WHITE,
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                ),
              ),
              Text(
                'Made For GAMERS',
                style: GoogleFonts.staatliches(
                  color: ProjectVariables.SEXY_WHITE,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              (_userShouldLoginOrSignup)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        ButtonTheme(
                          buttonColor: ProjectVariables.SEXY_WHITE,
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.staatliches(
                                color: ProjectVariables.MAIN_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ButtonTheme(
                          buttonColor: ProjectVariables.SEXY_WHITE,
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              'Signup',
                              style: GoogleFonts.staatliches(
                                color: ProjectVariables.MAIN_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
