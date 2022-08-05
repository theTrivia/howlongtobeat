import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Color hintTextColor;
  final Color borderColor;
  final Color inputTextColor;
  final Color focusedBorderColor;
  final bool obscureText;

  const InputField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.hintTextColor,
    required this.borderColor,
    required this.inputTextColor,
    required this.focusedBorderColor,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      style: TextStyle(
        color: inputTextColor,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: hintTextColor,
        ),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
        ),
      ),
    );
  }
}
