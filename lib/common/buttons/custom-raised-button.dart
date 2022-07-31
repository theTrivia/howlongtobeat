import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final methodToExecute;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final FontWeight fontWeight;

  const CustomRaisedButton({
    Key? key,
    required this.methodToExecute,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        buttonColor: buttonColor,
        minWidth: 100,
        child: RaisedButton(
          onPressed: () => methodToExecute,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ));
  }
}
