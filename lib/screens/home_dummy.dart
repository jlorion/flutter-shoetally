import 'package:commerce_mobile/models/UserProfile.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  User? user;
  Userprofile? userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    user = await AuthenticationService().getCurrentUser();
    if (user != null) {
      userProfile = await AuthenticationService().getUserProfile(user!); // Await and pass the user instance
    }
    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userProfile != null) ...[
              Text('Name: ${userProfile!.name}'),
              Text('Email: ${userProfile!.email}'),
            ] else ...[
              const Text('No user data available'),
            ],
            ElevatedButton(
              onPressed: () async {
                await AuthenticationService().signOut();
              },
              child: const Text('SignOut'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dummy');
              },
              child: const Text('NextPage'),
            )
          ],
        ),
      ),
    );
  }
}
