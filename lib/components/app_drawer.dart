import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/Wrapper.dart';
import 'package:commerce_mobile/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFA259FF),
            ),
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: FutureBuilder<DocumentSnapshot>(
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
                  // Now properly returning the Row widget
                  return Row(
                    children: [
                      const CircleAvatar(
                        radius: 25, // Adjust size of avatar
                        child: Icon(
                          Icons.person,
                          size: 25,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name, // User name
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              email, // User email or other info
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          // Other ListTiles for navigation
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Products'),
            onTap: () {
              Navigator.pushNamed(context, '/products');
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushNamed(context, '/orders');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Transaction History'),
            onTap: () {
              Navigator.pushNamed(context, '/transaction_history');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Customer List'),
            onTap: () {
              Navigator.pushNamed(context, '/customer-list');
            },
          ),
        ],
      ),
    );
  }
}
