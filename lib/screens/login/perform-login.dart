import 'package:firebase_auth/firebase_auth.dart';

class PerformLogin {
  static performLogin(email, password) async {
    try {
      final loginCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = loginCred.user?.uid;
      return {
        'uid': uid,
        'loginStatus': 'success',
      };
    } on FirebaseAuthException catch (e) {
      return {'loginStatus': e.code, 'userCredential': {}};
    }
  }
}
