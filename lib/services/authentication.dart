import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/models/AuthUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Register User
  Future<void> createUser(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      AuthUser? authUser = connectToAuthUser(user);
      //Create a Documment
      await createUserDocumment(authUser!, name);
    } on Exception catch (e) {
      print('Error : $e');
    }
  }

  //User Document
  Future<void> createUserDocumment(AuthUser user, String name) async {
    CollectionReference collection = firestore.collection('users');
    await collection.doc(user.uid).set({
      'uid': user.uid,
      'name': name,
      'email': user.email,
    });
  }

  //Login User
  Future<AuthUser?> loginUser(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return connectToAuthUser(user);
    } on Exception catch (e) {
      print('Error : $e');
    }
    return null;
  }

  //Logout
  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }

    //Stream Authentication User 
  Stream<AuthUser?> get user {  
    return _auth.authStateChanges().map(connectToAuthUser);
  }

  //bind User to AuthUser
  AuthUser? connectToAuthUser(User? user) {
    return user != null
        ? AuthUser(
            uid: user.uid,
            isEmailVerified: user.emailVerified,
            email: user.email)
        : null;
  }
}
