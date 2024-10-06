import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('assets/splash_screen.json'),
      ),
      nextScreen: LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2300,
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white,
    );
  }
}
