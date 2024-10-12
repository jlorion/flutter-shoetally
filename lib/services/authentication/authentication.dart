import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/models/UserProfile.dart';
import 'package:commerce_mobile/services/authentication/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Get Current User
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

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
        //Create a Documment
        await createUserDocumment(user, name);
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
  Future<void> createUserDocumment(User user, String name) async {
    CollectionReference collection = firestore.collection('users');
    await collection.doc(user.uid).set({
      'id': user.uid,
      'name': name,
      'email': user.email,
    });
  }

  Future<void> updateDocumment(User user) async {
    CollectionReference collection = firestore.collection('users');
    await collection.doc(user.uid).update({
      'email': user.email,
    });
  }

  //Login User
  Future<User?> loginUser(
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

        await updateDocumment(user);
        return user;
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
  Future<void> signOut() async {
    await _auth.signOut();
  }


  //Set User Profile Document
  Future<Userprofile?> getUserProfile(User? user) async {
    try {
      // Reference to the Firestore document
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      // Check if document exists
      if (doc.exists) {
        // Extract data from the document
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Return a Userprofile object
        return Userprofile(
          id: doc.id,
          name: data['name'],
          email: data['email'],
        );
      } else {
        developer.log("Document does not exist");
        return null;
      }
    } catch (e) {
      developer.log("Error fetching user profile: $e");
      return null;
    }
  }

  //change Name
  Future<void> updateUserName(String userId, String newName) async {
    try {
      // Reference to the document in the "users" collection
      DocumentReference userDocRef = firestore.collection('users').doc(userId);

      // Update the "name" field
      await userDocRef.update({
        'name': newName, // Field name and new value
      });

      developer.log('User name updated successfully.');
    } catch (e) {
      developer.log('Error updating user name: $e');
      throw e;
    }
  }

  //Change Email
  Future<void> updateEmail(String newEmail, String currentPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Re-authenticate the user to confirm the change
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // Now verify before updating the email
        await user.verifyBeforeUpdateEmail(newEmail);
        await user.reload();
        // Send a confirmation message or prompt to inform the user
        developer.log(
            'Verification email sent to $newEmail. Please verify to complete the update.');
      } else {
        developer.log('No user is currently signed in.');
      }
    } catch (e) {
      developer.log('Error updating email: $e');
      throw e;
    }
  }

  //Change Password
  Future<void> updatePassword(
      String newPassword, String currentPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Prompt for re-authentication using the user's credentials
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        // Re-authenticate the user
        await user.reauthenticateWithCredential(credential);

        // Proceed with updating the password
        await user.updatePassword(newPassword);
        await user.reload(); // Reload the user to update info
        developer.log('Password updated successfully.');
      } else {
        developer.log('No user is currently signed in.');
      }
    } catch (e) {
      developer.log('Error updating password: $e');
      throw e;
    }
  }

  
}
