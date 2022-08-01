import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './perform-signup.dart';
import '../../common/widgets/input-field.dart';
import '../../project-variables.dart';

class Signup extends StatelessWidget {
  final secureStorage = FlutterSecureStorage();
  var emailTextController = new TextEditingController();
  var passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectVariables.BACKGROUND_COLOR,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'signup',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
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
                onPressed: () async {
                  var signupResult = await PerformSingup.performSignup(
                    emailTextController.text,
                    passwordTextController.text,
                  );
                  if (signupResult == true) {
                    print('Sign up successful');
                    Navigator.pushNamed(context, '/login');
                  } else {
                    print('some error occured');
                  }
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: ProjectVariables.INPUT_TEXT_COLOR_2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
