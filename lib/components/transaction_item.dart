// transaction_item.dart
import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionItemComponent {
  static Widget transactionItem(
      BuildContext context, String title, String price, String dateTime, Transactions trans) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/transaction_details', arguments: trans);
          },
          child: ListTile(
            title: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 98, 54, 155),
              ),
            ),
            subtitle: Text(dateTime, style: GoogleFonts.inter(fontSize: 11)),
            trailing: Text(
              "₱ $price",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 98, 54, 155),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
