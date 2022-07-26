import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hltb/common/input-field.dart';
import 'package:hltb/screens/signup/perform-signup.dart';

class Signup extends StatelessWidget {
  final secureStorage = FlutterSecureStorage();
  var emailTextController = new TextEditingController();
  var passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Text('SIGN UP'),
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
            // onPressed: () async {
            //   var loginResult = await PerformLogin.performLogin(
            //       emailTextController.text, passwordTextController.text);
            //   print(loginResult.user.uid);

            //   await secureStorage.write(key: 'isUserLoggedIn', value: 'true');

            //   //Storing the login state in flutter secure storage
            // },
            onPressed: () async {
              var signupResult = await PerformSingup.performSignup(
                  emailTextController.text, passwordTextController.text);
              if (signupResult == true) {
                print('Sign up successful');
              } else {
                print('some error occured');
              }
            },
            child: Text('Sign up'),
          )
        ],
      )),
    );
  }
}
