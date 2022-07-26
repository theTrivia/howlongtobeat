import 'package:firebase_auth/firebase_auth.dart';
import './helper-function.dart';

class PerformSingup {
  static performSignup(email, password) async {
    var createUserResult = await createUser(email, password);
    var res = await addNewUserToUsersDatabase(createUserResult.user.uid).then(
      (_) {
        return true;
      },
    );
    // print(res);
    return res;
  }

  static createUser(email, password) async {
    try {
      final signupCreds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // var db = FirebaseFirestore.instance;
      // final credential =
      //     await db.collection("users").doc(loginCred.user!.uid).get();

      // return {
      //   'loginStatus': 'login-success',
      //   'userCredential': credential.data()
      // };
      return signupCreds;
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
