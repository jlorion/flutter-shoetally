import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:commerce_mobile/screens/dashboard.dart';
import 'package:commerce_mobile/screens/orders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Receipt extends StatefulWidget {
  final stringId;
  final total_amount;
  final Transactions trans;
  const Receipt(
      {super.key,
      required this.stringId,
      required this.total_amount,
      required this.trans});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  receiptTextDetail(leftText, rightText, int fontS) => Padding(
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
                fontSize: fontS.toDouble(),
                color: const Color.fromARGB(255, 18, 18, 18),
              ),
            ),
          ],
        ),
      );

  topButtons() => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // button1
            SizedBox.fromSize(
              size: const Size(38, 38),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    width: 2.0,
                  ),
                ),
                child: ClipOval(
                  child: Material(
                    color: const Color(0xFFA259FF),
                    child: InkWell(
                      splashColor: const Color.fromARGB(255, 190, 190, 190),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(),
                          ),
                        );
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 220),

            // button2
            SizedBox.fromSize(
              size: const Size(38, 38),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    width: 2.0,
                  ),
                ),
                child: ClipOval(
                  child: Material(
                    color: const Color(0xFFA259FF),
                    child: InkWell(
                      splashColor: const Color.fromARGB(255, 190, 190, 190),
                      onTap: () {},
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.ios_share, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
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
      body: Stack(
        children: [
          // Background color
          Container(
            color: Color(0xFFA259FF),
          ),
          // Main content
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    topButtons(),
                    const SizedBox(height: 25),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // White receipt container
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
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
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 236, 246, 230),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Text(
                                    'Payment Success!',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'RN: ${widget.stringId}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color.fromRGBO(
                                          108, 58, 172, 100),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // receiptTextDetail(
                                  //     'Reference ID', widget.stringId, 15),

                                  receiptTextDetail('Date',
                                      widget.trans.date_time.split(" ")[0], 15),
                                  const SizedBox(height: 15),
                                  receiptTextDetail('Time',
                                      widget.trans.date_time.split(" ")[1], 15),
                                  const SizedBox(height: 15),
                                  receiptTextDetail(
                                      'Payment Method', 'Credit Card', 15),
                                  const SizedBox(height: 15),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  receiptTextDetail(
                                      'Amount',
                                      '₱ ${widget.total_amount.toString()}',
                                      20),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Small circle between white container and background
                        Positioned(
                          left: 20,
                          bottom:
                              330, // Adjust this based on where you want the circle to appear
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Color(0xFFA259FF), // Same as background color
                            ),
                          ),
                        ),

                        Positioned(
                          right: 20,
                          bottom:
                              330, // Adjust this based on where you want the circle to appear
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Color(0xFFA259FF), // Same as background color
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 65),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: Size(300, 50),
                      ),
                      child: buttonTxt('Back to Home'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
