import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/circle_avatar_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:commerce_mobile/components/passwordfields.dart';
import 'package:commerce_mobile/services/authentication/auth_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:commerce_mobile/models/UserProfile.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController phoneTextField = TextEditingController();
  final TextEditingController newpasswordTextField = TextEditingController();
  final TextEditingController currentpasswordTextField =
      TextEditingController();

  final AuthenticationService _authService = AuthenticationService();
  Userprofile? userProfile; // To store the fetched user profile

  @override
  void initState() {
    super.initState();
    fetchUserProfile(); // Fetch user profile on page load
  }

  // Fetch user profile from Firestore
  Future<void> fetchUserProfile() async {
    User? currentUser = await _authService.getCurrentUser();
    if (currentUser != null) {
      Userprofile? profile = await _authService.getUserProfile(currentUser);
      if (profile != null) {
        setState(() {
          userProfile = profile;
          nameTextField.text = profile.name; // Set name to text field
          emailTextField.text = profile.email; // Set email to text field
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Profile"), // Custom app bar
      drawer: const AppDrawer(), // Custom drawer
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonComponent(),
                const Center(
                  child: CircleAvatarComponent(), // Avatar with photo upload
                ),
                const SizedBox(height: 20),
                InputFields(
                  label: 'Name',
                  hintText: 'Enter your name',
                  controllerTextField: nameTextField,
                ),
                const SizedBox(height: 16),
                InputFields(
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  controllerTextField: emailTextField,
                ),
                const SizedBox(height: 16),
                Text(
                  'Current Password',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF766789),
                  ),
                ),
                const SizedBox(height: 3),
                PasswordFields(
                  passlabel: 'Current Password',
                  hintText: 'Current Password',
                  controllerTextField: currentpasswordTextField,
                ),
                const SizedBox(height: 16),
                Text(
                  'New Password',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF766789),
                  ),
                ),
                const SizedBox(height: 3),
                PasswordFields(
                  passlabel: 'New Password',
                  hintText: 'New Password',
                  controllerTextField: newpasswordTextField,
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    onPressed: () async {
                      try {
                        User? user = await _authService.getCurrentUser();

                        // Update name if the field is not empty
                        if (nameTextField.text.isNotEmpty) {
                          await _authService.updateUserName(
                              user!.uid, nameTextField.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profile updated successfully!')),
                          );
                        }

                        // Validate and update email if the field is not empty
                        if (emailTextField.text.isNotEmpty &&
                            currentpasswordTextField.text.isNotEmpty) {
                          await _authService.updateEmail(
                              emailTextField.text.trim(),
                              currentpasswordTextField.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Verification email sent!')),
                          );
                        }

                        // Update password if the field is not empty
                        if (newpasswordTextField.text.isNotEmpty &&
                            currentpasswordTextField.text.isNotEmpty) {
                          await _authService.updatePassword(
                              newpasswordTextField.text.trim(),
                              currentpasswordTextField.text.trim());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Change password successfully!')),
                          );

                          await AuthFunctions().signOut();

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login',
                            (route) => false,
                          );
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/profile',
                            (route) => false,
                          );
                        }
                      } on Exception {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error updating profile')),
                        );
                      }
                    },
                    text: 'Update',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
