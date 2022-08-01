import 'package:flutter/material.dart';

import '../../project-variables.dart';

class Metascore extends StatelessWidget {
  final String ms;
  const Metascore({required this.ms});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 10000,
      color: ProjectVariables.MAIN_COLOR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Metacritic Score',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ms,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 179, 0),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
