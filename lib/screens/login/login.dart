import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hltb/common/widgets/loading-anime.dart';
import '../../common/widgets/input-field.dart';
import '../../providers/popular-games-provider.dart';
import './perform-login.dart';

import 'package:provider/provider.dart';

import '../../providers/user-favourite-game-provider.dart';
import '../../project-variables.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final secureStorage = FlutterSecureStorage();

  var emailTextController = new TextEditingController();

  var passwordTextController = new TextEditingController();
  var _shouldWeLoadAnime = false;

  methodToExec(context) async {
    var loggedInUser = await PerformLogin.performLogin(
        emailTextController.text, passwordTextController.text);
    print(loggedInUser['uid']);

    if (loggedInUser['loginStatus'].toString() == 'success') {
      //Storing the login state in flutter secure storage
      await secureStorage.write(key: 'isUserLoggedIn', value: 'true');
      await secureStorage.write(
        key: 'uid',
        value: loggedInUser['uid'].toString(),
      );

      //fetching users favourite games list after login
      await Provider.of<UserFavouriteGameProvider>(context, listen: false)
          .fetchFavouriteGameDetails();

      Navigator.pushNamed(context, '/mainPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/splashScreen');
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ProjectVariables.BACKGROUND_COLOR,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: (_shouldWeLoadAnime == true)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnime(ProjectVariables.SEXY_WHITE),
                    Text(
                      'Logging you in...',
                      style: TextStyle(
                        color: ProjectVariables.SEXY_WHITE,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'login',
                      style: TextStyle(
                        fontSize: 35,
                        color: ProjectVariables.SEXY_WHITE,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      hintText: 'Email',
                      textEditingController: emailTextController,
                      borderColor: ProjectVariables.SEXY_WHITE,
                      focusedBorderColor: ProjectVariables.SEXY_WHITE,
                      hintTextColor: ProjectVariables.SEXY_WHITE,
                      inputTextColor: ProjectVariables.SEXY_WHITE,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      hintText: 'Password',
                      textEditingController: passwordTextController,
                      borderColor: ProjectVariables.SEXY_WHITE,
                      focusedBorderColor: ProjectVariables.SEXY_WHITE,
                      hintTextColor: ProjectVariables.SEXY_WHITE,
                      inputTextColor: ProjectVariables.SEXY_WHITE,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonTheme(
                      buttonColor: ProjectVariables.SEXY_WHITE,
                      minWidth: MediaQuery.of(context).size.width * 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: RaisedButton(
                        //User Login
                        onPressed: () async {
                          setState(() {
                            _shouldWeLoadAnime = true;
                          });
                          var loggedInUser = await PerformLogin.performLogin(
                              emailTextController.text,
                              passwordTextController.text);
                          print(loggedInUser['uid']);

                          if (loggedInUser['loginStatus'].toString() ==
                              'success') {
                            //Storing the login state in flutter secure storage
                            await secureStorage.write(
                                key: 'isUserLoggedIn', value: 'true');
                            await secureStorage.write(
                              key: 'uid',
                              value: loggedInUser['uid'].toString(),
                            );

                            //fetching users favourite games list after login
                            await Provider.of<UserFavouriteGameProvider>(
                                    context,
                                    listen: false)
                                .fetchFavouriteGameDetails();

                            await Provider.of<PopularGamesProvider>(context,
                                    listen: false)
                                .getPopularGames();

                            setState(() {
                              _shouldWeLoadAnime = false;
                            });

                            Navigator.pushNamed(context, '/mainPage');
                          } else {
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ProjectVariables.MAIN_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        )),
      ),
    );
  }
}
