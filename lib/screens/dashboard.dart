
import 'package:commerce_mobile/compontents/app_drawer.dart';
import 'package:commerce_mobile/compontents/transaction_item.dart';
import 'package:commerce_mobile/compontents/app_drawer.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Map<String, String>> _transactions = [
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '₱ 25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '₱ 25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Kyle Dellatan',
      'price': '₱ 25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '₱ 25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '₱ 25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        backgroundColor: const Color(0xFFA259FF),
        foregroundColor: Colors.white,
        title: Text(
          "Dashboard",
          style: GoogleFonts.inter(
            fontSize: 24,
            letterSpacing: -0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Open the drawer using the GlobalKey
          },
        ),
      ),
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
                  _infoCard("Total Products", "189893"),
                  const SizedBox(height: 16),
                  _infoCard("Number of Customers", "25"),
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
            // Transactions List
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _transactions.length > 3 ? 3 : _transactions.length,
                itemBuilder: (context, index) {

                  return TransactionItemComponent.transactionItem(
                    _transactions[index]['title']!,
                    _transactions[index]['price']!,
                    _transactions[index]['dateTime']!,
                  );
                },
              ),
            ),
            // View All Transactions Button
            Center(
              child: TextButton(
                onPressed: () {},
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFA259FF),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
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
            "$price / Unit",
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
