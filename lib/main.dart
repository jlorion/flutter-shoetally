import 'package:commerce_mobile/screens/dashboard.dart';
import 'package:commerce_mobile/Wrapper.dart';
import 'package:commerce_mobile/firebase_options.dart';
import 'package:commerce_mobile/models/AuthUser.dart';
import 'package:commerce_mobile/screens/dashboard.dart';
import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:commerce_mobile/screens/signup_screen.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:commerce_mobile/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:commerce_mobile/screens/splash_screen.dart';
import 'package:commerce_mobile/screens/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'testing/imagetest.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    
    ChangeNotifierProvider(
      create: (context)=> StorageService(),
      child: StreamProvider<AuthUser?>.value(
        value: AuthenticationService().user,
        initialData: null,
        child: MaterialApp(
            home: Imagetest(),
            debugShowCheckedModeBanner: false,
            routes: {
              '/login': (context) => const Imagetest(),
              '/signup': (context) => const SignupScreen(),
              '/dashboard': (context) => Dashboard(),
              '/transaction_history': (context) => TransactionHistory(),
          }),
      ),
    ),
  );
}
