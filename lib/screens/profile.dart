import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/circle_avatar_component.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/models/UserProfile.dart';
import 'package:commerce_mobile/services/authentication/auth_functions.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
      userProfile = await AuthenticationService()
          .getUserProfile(user!); // Await and pass the user instance
    }
    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "User Profile"), // Custom app bar
      drawer: const AppDrawer(), // Custom drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatarComponent(), // Avatar with photo
                    const SizedBox(height: 16),
                    Text(
                      userProfile!.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user!.email.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Edit Profile"),
                      onTap: () {
                        Navigator.pushNamed(context, '/edit-profile');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Verify Email"),
                      onTap: () async {
                        User? user =
                            await AuthenticationService().getCurrentUser();
                        await user!.sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Verification Sent')),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Log Out"),
                      onTap: () async {
                        
                        await AuthFunctions().signOut();
                        User? user = await AuthFunctions().getCurrentUser();
                        
                        if (user == null) {
                          setState(() {
                            
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login',
                              (route) => false,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }
}
