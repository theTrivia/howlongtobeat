import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../methods/logout.dart';
import '../../project-variables.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.logout,
        color: ProjectVariables.SEXY_WHITE,
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: ProjectVariables.MAIN_COLOR,
                content: Text(
                  'Are you sure you want to Logout?',
                  style: GoogleFonts.barlowCondensed(
                    color: ProjectVariables.SEXY_WHITE,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Go Back',
                      style: GoogleFonts.barlowCondensed(
                        color: ProjectVariables.SEXY_WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: ProjectVariables.SEXY_WHITE,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await Logout.onLogout(context);
                      Navigator.pushNamed(context, '/splashScreen');
                    },
                    child: Text(
                      'Logout',
                      style: GoogleFonts.barlowCondensed(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.redAccent,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
