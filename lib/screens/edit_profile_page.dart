import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/circle_avatar_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:commerce_mobile/components/passwordfields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController nameTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController phoneTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();

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
                InputFields(
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controllerTextField: phoneTextField,
                ),
                const SizedBox(height: 16),
                Text(
                  'Password',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF766789),
                  ),
                ),
                const SizedBox(height: 3),
                PasswordFields(
                    passlabel: 'Password',
                    hintText: 'Password',
                    controllerTextField: passwordTextField),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    onPressed: () {},
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
