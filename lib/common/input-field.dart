import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;

  const InputField(
      {Key? key, required this.hintText, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: const TextStyle(
        color: Color.fromARGB(255, 72, 0, 255),
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(67, 255, 255, 255),
        ),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 72, 0, 255),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 72, 0, 255),
          ),
        ),
      ),
    );
  }
}
