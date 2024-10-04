import 'package:commerce_mobile/components/customer_component.dart';
import 'package:commerce_mobile/components/search_component.dart';
import 'package:flutter/material.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'edit_customer.dart'; // Import the EditCustomer page

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final List<Map<String, String>> _customers = [
    {
      'name': 'Makoy Reyes',
      'address': '123 Main St',
      'phoneNumber': '09123587964'
    },
    {'name': 'John Doe', 'address': '456 Elm St', 'phoneNumber': '09123587965'},
    {
      'name': 'Jane Smith',
      'address': '789 Maple St',
      'phoneNumber': '09123587966'
    },
    // Add more customers here
  ];

  List<Map<String, String>> _filteredCustomers = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _filteredCustomers = _customers; // Initialize with full customer list
  }

  void _filterCustomers(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredCustomers =
            _customers; // Reset to full list if search is empty
      } else {
        _filteredCustomers = _customers
            .where((customer) => customer['name']!
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  void _editCustomer(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCustomer(
          name: _filteredCustomers[index]['name']!,
          address: _filteredCustomers[index]['address']!, // Pass address
          phoneNumber: _filteredCustomers[index]['phoneNumber']!,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        // Update the customer data with the edited result
        _filteredCustomers[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Customer List"),
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
                  buttonText: 'Add Customer',
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-customer');
                  },
                ),
              ],
            ),
          ),
          SearchBarComponent(onChanged: _filterCustomers), // Search bar
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _filteredCustomers.length,
              itemBuilder: (context, index) {
                return CustomerComponent(
                  name: _filteredCustomers[index]['name']!,
                  phoneNumber: _filteredCustomers[index]['phoneNumber']!,
                  onEdit: () => _editCustomer(index), // Handle edit action
                  onDelete: () {
                    setState(() {
                      _filteredCustomers.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 1, // Assuming profile is index 2
      ),
    );
  }
}
