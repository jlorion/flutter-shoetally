import 'package:commerce_mobile/models/AuthUser.dart';
import 'package:commerce_mobile/screens/home_dummy.dart';
import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthUser?>(context);

    if (user != null) {
      return const HomeScreenWidget();
    } else {
      return const LoginScreen();
    }
  }
}