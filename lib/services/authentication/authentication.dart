import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/models/AuthUser.dart';
import 'package:commerce_mobile/services/authentication/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

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
      if (user != null) {
        AuthUser? authUser = connectToAuthUser(user);
        //Create a Documment
        await createUserDocumment(authUser!, name);
      } else {
        throw UserNotLoggedInAuthException;
      }
    } on FirebaseAuthException catch (e) {
      developer.log(
        'Login Error: ${e.code} - ${e.message}',
        error: e,
        name: 'loginUser', 
      );

      if (e.code == 'email-already-in-use') {
        //email address is already registered
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        //not formatted correctly
        throw InvalidEmailAuthException();
      } else if (e.code == 'weak-password') {
        //password provided is too weak
        throw WeakPasswordAuthException();
      } else if (e.code == 'operation-not-allowed') {
        //Email/password accounts are not enabled
        throw OperationNotAllowedAuthException();
      } else {
        //General Exception
        throw GenericAuthException();
      }
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        return connectToAuthUser(user);
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      developer.log(
        'Login Error: ${e.code} - ${e.message}',
        error: e,
        name: 'loginUser', 
      );
      if (e.code == 'user-not-found') {
        //No account found
        throw UserNotFoundAuthException();
      } else if (e.code == 'invalid-email') {
        //not formatted correctly
        throw InvalidEmailAuthException();
      } else if (e.code == 'wrong-password') {
        //password is incorrect
        throw WrongPasswordAuthException();
      } else if (e.code == 'too-many-requests') {
        //attempted to log in too many times
        throw TooManyRequestsAuthException();
      } else if (e.code == 'user-disabled') {
        //disabled by an administrator
        throw UserDisabledAuthException();
      } else if (e.code == 'invalid-credential') {
        //not formatted correctly
        throw InvalidCredentialAuthException();
      } else {
        //General Exception
        throw GenericAuthException();
      }
    }
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
