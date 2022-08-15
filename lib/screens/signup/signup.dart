import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/popular-games-provider.dart';
import './perform-signup.dart';
import '../../common/widgets/input-field.dart';
import '../../project-variables.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final secureStorage = const FlutterSecureStorage();

  var emailTextController = TextEditingController();

  var passwordTextController = TextEditingController();

  var confirmPasswordTextController = TextEditingController();

  bool _shouldShowError = true;
  String _errorMessage = '';

  final GlobalKey<FormState> _signupFormValidationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectVariables.BACKGROUND_COLOR,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Form(
          key: _signupFormValidationKey,
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
              InputField(
                hintText: 'Confirm Password',
                textEditingController: confirmPasswordTextController,
                borderColor: ProjectVariables.SEXY_WHITE,
                focusedBorderColor: ProjectVariables.SEXY_WHITE,
                hintTextColor: ProjectVariables.SEXY_WHITE,
                inputTextColor: ProjectVariables.SEXY_WHITE,
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              (_shouldShowError == true)
                  ? Text(
                      _errorMessage,
                      style: GoogleFonts.barlowCondensed(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : Container(),
              ButtonTheme(
                buttonColor: ProjectVariables.SEXY_WHITE,
                minWidth: MediaQuery.of(context).size.width * 0.3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: RaisedButton(
                  onPressed: () async {
                    //custom validation
                    if (!(emailTextController.text.contains('@') &&
                            emailTextController.text.contains('.')) ||
                        emailTextController.text.isEmpty) {
                      setState(() {
                        _shouldShowError = true;
                        _errorMessage = 'Please Enter Valid Email';
                      });
                      return;
                    } else if (passwordTextController.text.length < 6) {
                      setState(() {
                        _shouldShowError = true;
                        _errorMessage =
                            'Password must contain at least 6 characters';
                      });
                      return;
                    } else if (confirmPasswordTextController.text !=
                        passwordTextController.text) {
                      setState(() {
                        _shouldShowError = true;
                        _errorMessage = "Passwords doesnot match.";
                      });
                      return;
                    } else {
                      setState(() {
                        _shouldShowError = false;
                      });
                    }
                    var signupResult = await PerformSingup.performSignup(
                      emailTextController.text,
                      passwordTextController.text,
                    );

                    if (signupResult['signupStatus'] ==
                        'email-already-in-use') {
                      setState(() {
                        _shouldShowError = true;
                        _errorMessage =
                            'Email already in use. Please use a different one.';
                      });
                    }
                    if (signupResult['signupStatus'] == 'signup-success') {
                      print('Sign up successful');
                      Navigator.pushNamed(context, '/login');
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
        ),
      )),
    );
  }
}
