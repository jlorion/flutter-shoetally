import 'package:flutter/material.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          
        }, child: const Text('SignOut')),
      ),
    );
  }
}