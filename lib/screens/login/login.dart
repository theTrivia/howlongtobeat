import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../common/widgets/input-field.dart';
import './perform-login.dart';

import 'package:provider/provider.dart';

import '../../providers/user-favourite-game-provider.dart';
import '../../project-variables.dart';

class Login extends StatelessWidget {
  final secureStorage = FlutterSecureStorage();
  var emailTextController = new TextEditingController();
  var passwordTextController = new TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'login',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
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
                borderColor: ProjectVariables.BORDER_COLOR_1,
                focusedBorderColor: ProjectVariables.FOCUSED_BORDER_COLOR_1,
                hintTextColor: ProjectVariables.HINT_TEXT_COLOR_1,
                inputTextColor: ProjectVariables.INPUT_TEXT_COLOR_1,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                hintText: 'Password',
                textEditingController: passwordTextController,
                borderColor: ProjectVariables.BORDER_COLOR_1,
                focusedBorderColor: ProjectVariables.FOCUSED_BORDER_COLOR_1,
                hintTextColor: ProjectVariables.HINT_TEXT_COLOR_1,
                inputTextColor: ProjectVariables.INPUT_TEXT_COLOR_1,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonTheme(
                buttonColor: Colors.white,
                minWidth: MediaQuery.of(context).size.width * 0.3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: RaisedButton(
                  //User Login
                  onPressed: () async {
                    var loggedInUser = await PerformLogin.performLogin(
                        emailTextController.text, passwordTextController.text);
                    print(loggedInUser['uid']);

                    if (loggedInUser['loginStatus'].toString() == 'success') {
                      //Storing the login state in flutter secure storage
                      await secureStorage.write(
                          key: 'isUserLoggedIn', value: 'true');
                      await secureStorage.write(
                        key: 'uid',
                        value: loggedInUser['uid'].toString(),
                      );

                      //fetching users favourite games list after login
                      await Provider.of<UserFavouriteGameProvider>(context,
                              listen: false)
                          .fetchFavouriteGameDetails();

                      Navigator.pushNamed(context, '/mainPage');
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: ProjectVariables.INPUT_TEXT_COLOR_2,
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
