import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/app_drawer.dart';
import '../components/appbar.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  receiptTextDetail(leftText, rightText, fontS) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                leftText,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF766789),
                ),
              ),
            ),
            Text(
              rightText,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: fontS,
                color: const Color.fromARGB(255, 18, 18, 18),
              ),
            ),
          ],
        ),
      );

  productsListTextDetail(quantity, productName, price, fontS) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: Row(
          children: [
            Text(
              quantity,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: fontS,
                color: const Color(0xFF766789),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                productName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: fontS,
                  color: const Color.fromARGB(255, 18, 18, 18),
                ),
              ),
            ),
            Text(
              price,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: fontS,
                color: const Color.fromARGB(255, 18, 18, 18),
              ),
            ),
          ],
        ),
      );

  buttonTxt(txtHome) => Text(txtHome,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transaction Details"),
      drawer: const AppDrawer(),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // White receipt container
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    width: 365,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Icon(
                              Icons.history_edu,
                              size: 38,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Order to',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '[ADIDAS CO]',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Divider(color: Colors.grey.shade300, thickness: 1),
                            const SizedBox(height: 25),
                            receiptTextDetail(
                                'Reference Number', '000085752257', 15),
                            const SizedBox(height: 15),
                            receiptTextDetail('Date', 'Mar 22, 2023', 15),
                            const SizedBox(height: 15),
                            receiptTextDetail('Time', '07:80 AM', 15),
                            const SizedBox(height: 15),
                            receiptTextDetail(
                                'Payment Method', 'Credit Card', 15),
                            const SizedBox(height: 15),
                            Divider(color: Colors.grey.shade300, thickness: 1),
                            const SizedBox(height: 20),
                            receiptTextDetail('Amount', 'PHP 1,000.00', 20),
                            const SizedBox(height: 20),
                            Divider(color: Colors.grey.shade300, thickness: 1),
                            const SizedBox(height: 20),
                            Text(
                              'PRODUCTS LIST',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Product List
                            productsListTextDetail(
                                '1x', 'Air Jordans 1 High', 'PHP 1,500.00', 12),
                            const SizedBox(height: 13),
                            productsListTextDetail(
                                '1x', 'KOB Nike Precision', 'PHP 1,500.00', 12),
                            const SizedBox(height: 13),
                            productsListTextDetail(
                                '1x', 'Savory Adidas', 'PHP 1,500.00', 12),
                            const SizedBox(height: 13),

                            // Add more items here if needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              Text(
                'Need help? Go to Help Center',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ],
      ),
    );
  }
}
