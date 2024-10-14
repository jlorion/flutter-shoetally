import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/controllers/userController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/circle_avatar_component.dart';
import 'package:commerce_mobile/components/navbar.dart';

class UserProfilePage extends StatelessWidget {
  UserController userController = UserController();

  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "User Profile"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: userController.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data!.exists) {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              String name = userData['name'] ?? 'No name';
              String email = userData['email'] ?? 'No email';

              return Center(
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
                  child: IntrinsicHeight(
                    // Dynamically adjusts the height to fit content
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Prevent stretching
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatarComponent(),
                        const SizedBox(height: 16),
                        Text(
                          name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.settings_outlined),
                          title: Text("Edit Profile"),
                          onTap: () {
                            Navigator.pushNamed(context, '/edit-profile');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.email_outlined),
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
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text("User data not found"));
            }
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }
}
