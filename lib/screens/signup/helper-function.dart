import 'package:cloud_firestore/cloud_firestore.dart';

addNewUserToUsersDatabase(String uid) async {
  final db = FirebaseFirestore.instance;
  try {
    await db.collection('user-data').doc(uid).set(
      {
        'user_id': uid,
      },
    );
  } catch (e) {
    print(e);
  }
}
