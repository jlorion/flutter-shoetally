import 'package:commerce_mobile/compontents/inputfields.dart';
import 'package:commerce_mobile/compontents/passwordfields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameTextField = TextEditingController();
  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text(
              'Sign Up',
              style: GoogleFonts.inter(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6C3AAC),
                letterSpacing: -3,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputFields(
                      label: 'Name',
                      hintText: 'Write your name',
                      controllerTextField: nameTextField),
                  const SizedBox(height: 35),
                  InputFields(
                      label: 'Email',
                      hintText: 'johndoe@gmail.com',
                      controllerTextField: emailTextField),
                  const SizedBox(height: 35),
                  Text(
                    'Password',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF766789),
                    ),
                  ),
                  const SizedBox(height: 3),
                  PasswordFields(
                      passlabel: 'Password',
                      hintText: 'Password',
                      controllerTextField: passwordTextField),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFA259FF),
                  minimumSize: const Size.fromHeight(60),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 140, 140, 140),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                        setState(() {});
                      },
                      child: Text(
                        'Log in',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: const Color(0xFFA259FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
