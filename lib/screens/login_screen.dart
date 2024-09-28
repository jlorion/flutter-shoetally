import 'package:commerce_mobile/compontents/inputfields.dart';
import 'package:commerce_mobile/compontents/passwordfields.dart';
import 'package:commerce_mobile/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 35, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in',
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
                        label: 'Email',
                        hintText: 'Email',
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
                  onPressed: () async {
                    // Handle login logic here
                    try {
                      await AuthenticationService().loginUser(
                          emailTextField.text, passwordTextField.text);
                    } on Exception catch (e) {
                      print('Error: $e');
                    }
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
              const SizedBox(height: 35),
              Center(
                child: Text(
                  "Don't have an account?",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 140, 140, 140),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Google sign-in logic here

                      Navigator.pushNamed(context, '/signup');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.purple,
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 228, 228, 228),
                            width: 1.5),
                      ),
                    ),
                    label: Text(
                      'SIGN UP',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
