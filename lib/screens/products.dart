import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/productcard.dart';
import 'package:commerce_mobile/components/search_component.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final List<Map<String, String>> _transactions = [
    {
      'productName': 'Century Tuna Ila Bernard',
      'sellingPrice': '₱ 4,000.00',
      'purchasePrice': '₱ 3,000.00',
      'quantity': '30',
      'category': 'Shoes',
      'dateTime': 'September 29, 2024, 5:00 PM',
      'image': 'exampleImage'
    },
    {
      'productName': 'Nike Shoe',
      'sellingPrice': '₱ 4,000.00',
      'purchasePrice': '₱ 3,000.00',
      'quantity': '30',
      'category': 'Shoes',
      'dateTime': 'September 29, 2024, 5:00 PM',
      'image': 'exampleImage'
    },
    {
      'productName': 'Addidas Shoe',
      'sellingPrice': '₱ 4,000.00',
      'purchasePrice': '₱ 3,000.00',
      'quantity': '30',
      'category': 'Shoes',
      'dateTime': 'September 29, 2024, 5:00 PM',
      'image': 'exampleImage'
    },
    {
      'productName': 'Example Shoe',
      'sellingPrice': '₱ 4,000.00',
      'purchasePrice': '₱ 3,000.00',
      'quantity': '30',
      'category': 'Shoes',
      'dateTime': 'September 29, 2024, 5:00 PM',
      'image': 'exampleImage'
    },
    // More transactions...
  ];

  List<Map<String, String>> _filteredTransactions = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _filteredTransactions =
        _transactions; // Initialize with full transaction list
  }

  void _filterTransactions(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredTransactions =
            _transactions; // Reset to full list if search is empty
      } else {
        _filteredTransactions = _transactions
            .where((transaction) => transaction['productName']!
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: const CustomAppBar(title: "Products"),
      drawer: const AppDrawer(), 
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButtonComponent(),
                const Spacer(),
                IconButtonComponent(
                  buttonText: 'Add Product',
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-product');
                    print('Add Product button pressed');
                  },
                ),
              ],
            ),
          ),
          SearchBarComponent(onChanged: _filterTransactions),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProductCard(
                          filteredTransactions: _filteredTransactions,
                          index: index,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}
