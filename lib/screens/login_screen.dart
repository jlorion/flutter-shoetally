import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
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
                  Text(
                    'Email',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF766789),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailTextField,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'Password',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF766789),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordTextField,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      value: _showPassword,
                      onChanged: (bool? value) {
                        setState(
                        () {
                          _showPassword = value ?? false;
                        },
                        );
                      },
                      ),
                      InkWell(
                      onTap: () {
                        setState(() {
                        _showPassword = !_showPassword;
                        });
                      },
                      child: Text(
                        'Show Password',
                        style: GoogleFonts.inter(
                        fontSize: 15,
                        color: const Color(0xFF766789),
                        ),
                      ),
                      ),
                      const Spacer(),
                      InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.inter(
                        fontSize: 15,
                        color: const Color(0xFFA259FF),
                        ),
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
