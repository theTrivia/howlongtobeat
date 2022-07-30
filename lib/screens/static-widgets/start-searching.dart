import 'package:flutter/material.dart';

class StartSearching extends StatelessWidget {
  const StartSearching({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Start Searching...',
              style: TextStyle(
                // color: Color.fromARGB(62, 255, 255, 255),
                color: Color.fromARGB(86, 72, 0, 255),

                fontSize: 30,
              ),
            ),
            Icon(
              Icons.gamepad,
              color: Color.fromARGB(86, 72, 0, 255),
              size: 75.0,
            ),
          ],
        ),
      ),
    );
  }
}
