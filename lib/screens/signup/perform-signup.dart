import 'package:firebase_auth/firebase_auth.dart';
import './helper-function.dart';

class PerformSingup {
  static performSignup(email, password) async {
    var createUserResult = await createUser(email, password);

    if (createUserResult['signupStatus'] == 'success') {
      await addNewUserToUsersDatabase(
              createUserResult['userCredential'].user.uid)
          .then(
        (res) {
          return true;
        },
      );
      return {'signupStatus': 'signup-success'};
    } else if (createUserResult['signupStatus'] == 'email-already-in-use') {
      return {'signupStatus': 'email-already-in-use'};
    }
  }

  static createUser(email, password) async {
    try {
      final signupCreds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return {'signupStatus': 'success', 'userCredential': signupCreds};
    } on FirebaseAuthException catch (e) {
      return {'signupStatus': e.code, 'userCredential': {}};
    }
  }
}
