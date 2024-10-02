import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:flutter/material.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()async {
          //functions
          await AuthenticationService().signOut();
        }, child: const Text('SignOut')),
      ),
    );
  }
}