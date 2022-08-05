import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/popular-games-provider.dart';
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
            Text(
              'signup',
              style: GoogleFonts.staatliches(
                color: ProjectVariables.SEXY_WHITE,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
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
                  style: GoogleFonts.staatliches(
                    color: ProjectVariables.MAIN_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
