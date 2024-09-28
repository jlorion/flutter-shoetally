import 'package:commerce_mobile/Wrapper.dart';
import 'package:commerce_mobile/firebase_options.dart';
import 'package:commerce_mobile/models/AuthUser.dart';
import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:commerce_mobile/screens/signup_screen.dart';
import 'package:commerce_mobile/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    StreamProvider<AuthUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
          home: const Wrapper(),
          debugShowCheckedModeBanner: false,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
          }),
    ),
  );
}
