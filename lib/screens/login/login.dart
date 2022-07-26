import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hltb/common/input-field.dart';
import 'package:hltb/screens/login/perform-login.dart';

class Login extends StatelessWidget {
  final secureStorage = FlutterSecureStorage();
  var emailTextController = new TextEditingController();
  var passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text('Sign In'),
          const SizedBox(
            height: 10,
          ),
          InputField(
            hintText: 'Email',
            textEditingController: emailTextController,
          ),
          const SizedBox(
            height: 10,
          ),
          InputField(
            hintText: 'Password',
            textEditingController: passwordTextController,
          ),
          const SizedBox(
            height: 10,
          ),
          RaisedButton(
            //User Login
            onPressed: () async {
              var loggedInUserId = await PerformLogin.performLogin(
                  emailTextController.text, passwordTextController.text);
              print(loggedInUserId['uid']);

              if (loggedInUserId['loginStatus'].toString() == 'success') {
                //Storing the login state in flutter secure storage
                await secureStorage.write(key: 'isUserLoggedIn', value: 'true');
                await secureStorage.write(
                  key: 'uid',
                  value: loggedInUserId.toString(),
                );

                Navigator.pushNamed(context, '/appMainPage');
              }
            },
            child: Text('Login'),
          )
        ],
      )),
    );
  }
}
