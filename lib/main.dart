import 'package:commerce_mobile/Wrapper.dart';
import 'package:commerce_mobile/firebase_options.dart';
import 'package:commerce_mobile/models/AuthUser.dart';
import 'package:commerce_mobile/screens/add_customer.dart';
import 'package:commerce_mobile/screens/dashboard.dart';
import 'package:commerce_mobile/screens/add_product.dart';
import 'package:commerce_mobile/screens/customer_list.dart';
import 'package:commerce_mobile/screens/edit_product.dart';
import 'package:commerce_mobile/screens/edit_profile_page.dart';
import 'package:commerce_mobile/screens/login_screen.dart';
import 'package:commerce_mobile/screens/order_list.dart';
import 'package:commerce_mobile/screens/orders.dart';
import 'package:commerce_mobile/screens/products.dart';
import 'package:commerce_mobile/screens/profile.dart';
import 'package:commerce_mobile/screens/signup_screen.dart';
import 'package:commerce_mobile/screens/transaction_details.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:commerce_mobile/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:commerce_mobile/screens/splash_screen.dart';
import 'package:commerce_mobile/screens/transaction_history.dart';
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
      create: (context) => StorageService(), 
      child: StreamProvider<AuthUser?>.value(
          value: AuthenticationService().user,
          initialData: null,
          child: MaterialApp(
              home: const TransactionDetails(),
              debugShowCheckedModeBanner: false,
              routes: {
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignupScreen(),
                '/dashboard': (context) => Dashboard(),
                '/transaction_history': (context) => TransactionHistory(),
                '/products': (context) => Products(),
                '/profile': (context) => UserProfilePage(),
                '/add-product': (context) => AddProduct(),
                    '/add-customer': (context) => AddCustomer(),
                '/customer-list': (context) => CustomerList(),
                '/edit-profile': (context) => EditProfilePage(),
                '/orders': (context) => OrderScreen(),
                '/order-list': (context) => OrderListPage(),
              }),
        ),
    )
  );
}
