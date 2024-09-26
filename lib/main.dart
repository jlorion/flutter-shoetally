import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
void main() => runApp(ShoeTallyApp());

class ShoeTallyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
