import 'package:cloud_firestore/cloud_firestore.dart';

fetchUserDataFromUser(uid) {
  try {
    var db = FirebaseFirestore.instance;
  } catch (e) {
    print(e);
  }
}
