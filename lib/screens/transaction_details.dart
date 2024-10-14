import 'package:commerce_mobile/components/appbarBack.dart';
import 'package:commerce_mobile/controllers/Transaction_Contorller.dart';
import 'package:commerce_mobile/models/OrdersModel.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';
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
  Transactions? trans;
  List<Orders> orders = [];
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
              rightText ?? '',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: fontS.toDouble(),
                color: const Color.fromRGBO(108, 58, 172, 100),
              ),
            ),
          ],
        ),
      );

  Widget productsListTextDetail(quantity, productName, price, int fontS) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: Row(
          children: [
            Text(
              quantity,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: fontS.toDouble(),
                color: const Color(0xFF766789),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                productName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: fontS.toDouble(),
                  color: const Color.fromRGBO(108, 58, 172, 100),
                ),
              ),
            ),
            Text(
              price.toString(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: fontS.toDouble(),
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

  currentTrans() {
    final args = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      trans = args as Transactions;
    });
    populateOrders();
  }

  populateOrders() async {
    if (trans?.id != null) {
      final prods = await TransactionContorller().getOrders(trans!.id);
      setState(() {
        orders = prods;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => currentTrans());
    populateOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(title: "Transaction Details"),
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
                                color: const Color.fromRGBO(108, 58, 172, 100),
                              ),
                            ),
                            Text(
                              '[${trans?.customer_name}]',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromRGBO(108, 58, 172, 100),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Divider(color: Colors.grey.shade300, thickness: 1),
                            const SizedBox(height: 25),
                            receiptTextDetail(
                                'Reference Number', trans?.id, 10),
                            const SizedBox(height: 15),
                            receiptTextDetail('Date',
                                trans?.date_time.split(' ')[0] ?? "", 15),
                            const SizedBox(height: 15),
                            receiptTextDetail('Time',
                                trans?.date_time.split(" ")[1] ?? "", 15),
                            const SizedBox(height: 15),
                            receiptTextDetail(
                                'Payment Method', 'Credit Card', 15),
                            const SizedBox(height: 15),
                            Divider(color: Colors.grey.shade300, thickness: 1),
                            const SizedBox(height: 20),
                            receiptTextDetail(
                                'Amount',
                                'PHP ${trans?.total_amount.toStringAsFixed(2) ?? ""}',
                                20),
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
                            Column(
                                children: orders
                                    .map((order) => productsListTextDetail(
                                        order.quantity.toString(),
                                        order.product_name,
                                        order.total_price.toStringAsFixed(2),
                                        12))
                                    .toList())
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
