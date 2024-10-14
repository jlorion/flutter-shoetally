import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawerProfile extends StatefulWidget {
  const AppDrawerProfile({super.key});

  @override
  State<AppDrawerProfile> createState() => _AppDrawerProfileState();
}

class _AppDrawerProfileState extends State<AppDrawerProfile> {
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: userController.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data available'));
        } else {
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['name'] ?? 'No name';
          String email = userData['email'] ?? 'No email';
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFA259FF),
                ),
                margin: EdgeInsets.zero,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25, // adjust size of avatar
                          child: Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.black45,
                          ),
                        ),
                        // const Icon(Icons.percent, size: 25),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name, // user name
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              email, // user email or other info
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
