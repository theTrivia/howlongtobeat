import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hltb/project-variables.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  void initState() {
    super.initState();

    secureStorage.read(key: 'uid').then((uid) {
      if (uid == null) {
        setState(() {
          _userShouldLoginOrSignup = true;
        });
      } else {
        doAsyncJob(context).then((_) {
          Navigator.pushNamed(context, '/mainPage');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 72, 0, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'howlongtobeat',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              'Made For GAMERS',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w900,
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
                        buttonColor: Colors.white,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ProjectVariables.INPUT_TEXT_COLOR_2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ButtonTheme(
                        buttonColor: Colors.white,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ProjectVariables.INPUT_TEXT_COLOR_2,
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
    );
  }
}
