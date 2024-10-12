import 'package:commerce_mobile/screens/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBarBack({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFA259FF),
      foregroundColor: Colors.white,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 24,
          letterSpacing: -0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionHistory(),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
