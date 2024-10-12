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
import 'package:commerce_mobile/services/authentication/authentication.dart'; // Import your service

class EditProfilePage extends StatelessWidget {
  final TextEditingController nameTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController phoneTextField = TextEditingController();
  final TextEditingController newpasswordTextField = TextEditingController();
  final TextEditingController currentpasswordTextField =
      TextEditingController();

  final AuthenticationService _authService = AuthenticationService();

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
                        User? user = await AuthFunctions().getCurrentUser();

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
                        User? user = await AuthFunctions().getCurrentUser();
                        
                        if (user == null) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login',
                              (route) => false,
                            );
                        }
                        }
                      } on Exception {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error updating password ')),
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
