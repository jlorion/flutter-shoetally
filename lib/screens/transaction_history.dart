import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/search_field_component.dart';
import 'package:commerce_mobile/components/transaction_item.dart'; // Import the new transaction item component
import 'package:commerce_mobile/controllers/Transaction_Contorller.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:flutter/material.dart';


class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<Transactions> transList = [];
  final List<Map<String, String>> _transactions = [
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Kyle Dellatan',
      'price': '25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
    {
      'title': 'Century Tuna Ila Bernard',
      'price': '25,000.00',
      'dateTime': 'September 29, 2024, 5:00 PM'
    },
  ];

  List<Map<String, String>> _filteredTransactions = [];
  String _searchText = "";
  transPopulate()async{
    final listthing = await TransactionContorller().getTransactions();
    setState(() {
      transList = listthing;
    });
  }
  @override
  void initState() {
    super.initState();
    _filteredTransactions = _transactions;
    transPopulate();
  }

  void _filterTransactions(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredTransactions = _transactions;
      } else {
        _filteredTransactions = _transactions
            .where((transaction) => transaction['title']!
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transaction History"),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          SearchFieldComponent(
            onChanged: (value) => _filterTransactions(value),
          ),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
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
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TransactionItemComponent.transactionItem(context,
                      transaction['title']!,
                      transaction['price']!,
                      transaction['dateTime']!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
