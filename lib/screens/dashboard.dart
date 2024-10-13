import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/infocard.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/transaction_item.dart';
import 'package:commerce_mobile/controllers/Product_Controllers.dart';
import 'package:commerce_mobile/controllers/Transaction_Contorller.dart';
import 'package:commerce_mobile/controllers/customerController.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Product> products = [];
  List<Customers> customers = [];
  List<Transactions> _transactions = [];
  bool isLoading = true; // Loading state

  populateFromDatabase() async {
    final prods = await ProductControllers().getProducts();
    final clients = await CustomerController().getAllCustomers();
    final trans = await TransactionContorller().getTransactions();

    // Sort transactions by date in descending order
    trans.sort((a, b) => b.date_time.compareTo(a.date_time));

    setState(() {
      products = prods;
      customers = clients;
      _transactions = trans;
      isLoading = false; // Set loading to false when data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    populateFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Dashboard"),
      drawer: const AppDrawer(),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 35, 35, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product and Customer Info
            Center(
              child: Column(
                children: [
                  InfoCard(
                    title: 'Total Products',
                    value: products.fold({"totalstock": 0}, (premap, map) {
                      premap["totalstock"] =
                          premap["totalstock"]! + map.product_stock;
                      return premap;
                    })["totalstock"].toString(),
                  ),
                  const SizedBox(height: 9),
                  InfoCard(
                    title: 'Number of Customers',
                    value: customers.length.toString(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Profit Info
            _profitCard("Profit", "PHP 100,000"),
            const SizedBox(height: 35),
            // Transactions Title
            Text(
              "Transactions",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFA259FF),
              ),
            ),
            const SizedBox(height: 8),
            // Transactions List or Loading Indicator
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: const Color(
                            0xFFA259FF), // Customize color if needed
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          _transactions.length > 3 ? 3 : _transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionItemComponent.transactionItem(
                            context,
                            _transactions[index].customer_name,
                            _transactions[index]
                                .total_amount
                                .toStringAsFixed(2),
                            _transactions[index].date_time,
                            _transactions[index]);
                      },
                    ),
            ),
            // View All Transactions Button
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/transaction_history');
                },
                child: Text(
                  "View All Transactions",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA259FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 0, // Assuming profile is index 2
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFA259FF), // Purple background color
        borderRadius: BorderRadius.circular(7.0), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profitCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFA259FF),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFA259FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(String title, String price, String dateTime) {
    return Column(
      children: [
        ListTile(
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
            "$price",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 98, 54, 155),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ],
    );
  }
}
