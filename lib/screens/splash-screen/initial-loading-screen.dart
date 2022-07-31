import 'package:flutter/material.dart';

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 72, 0, 255),
      body: Center(
        // child: Text(
        //   'howlongtobeat',
        //   style: TextStyle(
        //     fontSize: 35,
        //     color: Colors.white,
        //     fontWeight: FontWeight.w900,
        //   ),
        // ),
        child: FutureBuilder(
          // future: doSomething(context),
          builder: (context, snapshot) {
            return const Text(
              'howlongtobeat',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            );
          },
        ),
      ),
    );
  }
}
