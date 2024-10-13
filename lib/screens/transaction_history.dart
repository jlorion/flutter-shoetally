import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/search_field_component.dart';
import 'package:commerce_mobile/components/transaction_item.dart'; // Import the new transaction item component
import 'package:commerce_mobile/controllers/Transaction_Contorller.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:commerce_mobile/seeders/transaction_seeder.dart';
import 'package:flutter/material.dart';


class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<Transactions> transList = [];

  List<Transactions> _filteredTransactions = [];
  String _searchText = "";
  
  transPopulate()async{
    final listthing = await TransactionContorller().getTransactions();
    // final listthing = TransactionSeeder().transListSeed();
    setState(() {
      transList = listthing;
      _filteredTransactions = transList;
    });
  }

  @override
  void initState() {
    super.initState();
    transPopulate();

  }

  void _filterTransactions(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredTransactions = transList;
      } else {
        _filteredTransactions = transList
            .where((transaction) => transaction.customer_name
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
                      transaction.customer_name,
                      transaction.total_amount.toStringAsFixed(2),
                      transaction.date_time,
                      transaction
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
