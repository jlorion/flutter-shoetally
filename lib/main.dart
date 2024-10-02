import 'package:commerce_mobile/screens/dashboard.dart';
import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:commerce_mobile/screens/signup_screen.dart';
import 'package:commerce_mobile/screens/splash_screen.dart';
import 'package:commerce_mobile/screens/transaction_history.dart';
import 'package:flutter/material.dart';

void main() => runApp(ShoeTallyApp());

class ShoeTallyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/dashboard': (context) => Dashboard(),
          '/transaction_history': (context) => TransactionHistory(),
        });
  }
}


//sample comment 