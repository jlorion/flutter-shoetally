import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/screens/dashboard.dart';
import 'package:commerce_mobile/screens/orders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
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
                    topButtons(),
                    const SizedBox(height: 25),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // White receipt container
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: 365,
                          height: 510,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
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
                                const SizedBox(height: 25),

                                
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
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
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                receiptTextDetail('Amount', 'PHP 1,000.00', 20),
                                const SizedBox(height: 20),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.download, size: 24),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    minimumSize: Size(300, 50),
                                  ),
                                  label: buttonTxt('Get PDF Receipt'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Small circle between white container and background
                        Positioned(
                          left: 40,
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
                          right: 40,
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
