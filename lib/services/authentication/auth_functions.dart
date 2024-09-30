import 'package:commerce_mobile/services/authentication/auth_error_dialog.dart';
import 'package:commerce_mobile/services/authentication/auth_exceptions.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:flutter/material.dart';

class AuthFunctions {
  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await AuthenticationService().loginUser(email, password);
    } on InvalidCredentialAuthException {
      await showErrorDialog(context, 'Invalid Credential');
    } on InvalidEmailAuthException {
      await showErrorDialog(context, 'Invalid Email');
    } on UserDisabledAuthException {
      await showErrorDialog(context, 'User disabled');
    } on UserNotFoundAuthException {
      await showErrorDialog(context, 'User not found');
    } on WrongPasswordAuthException {
      await showErrorDialog(context, 'Wrong password');
    } on TooManyRequestsAuthException {
      await showErrorDialog(context, 'Too many requests');
    } on GenericAuthException {
      await showErrorDialog(context, 'General Error');
    }
  }

  Future<void> register(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      await AuthenticationService().createUser(email, password, name);
      await AuthenticationService().signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(context, 'email already in use');
    } on InvalidEmailAuthException {
      await showErrorDialog(context, 'invalid email');
    } on WeakPasswordAuthException {
      await showErrorDialog(context, 'weak password');
    } on OperationNotAllowedAuthException {
      await showErrorDialog(context, 'operation not allowed');
    } on GenericAuthException {
      await showErrorDialog(context, 'General Error');
    }
  }
}
