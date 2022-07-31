import 'package:firebase_auth/firebase_auth.dart';

class PerformLogin {
  static performLogin(email, password) async {
    try {
      final loginCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // var db = FirebaseFirestore.instance;
      // final credential =
      //     await db.collection("users").doc(loginCred.user!.uid).get();

      final uid = loginCred.user?.uid;
      return {
        'uid': uid,
        'loginStatus': 'success',
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // AppLogger.printErrorLog('user not found');
        print(e.code);
      } else if (e.code == 'wrong-password') {
        // AppLogger.printErrorLog('wrong password');
        print(e.code);
      }
      return {'loginStatus': e.code, 'userCredential': {}};
    }
  }
}
