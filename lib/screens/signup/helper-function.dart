import 'package:cloud_firestore/cloud_firestore.dart';

addNewUserToUsersDatabase(String uid) async {
  final db = FirebaseFirestore.instance;
  try {
    await db.collection('user-data').doc(uid).set(
      {
        'user-id': uid,
        'fav-games': [],
      },
    ).then((_) {
      print('Successfully added user to user\'s db');
      return 'success';
    });
  } catch (e) {
    print(e);
  }
}
