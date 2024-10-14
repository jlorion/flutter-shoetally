import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return firestore.collection('users').doc(user.uid).get();
    } else {
      throw Exception("No user is logged in.");
    }
  }
}
