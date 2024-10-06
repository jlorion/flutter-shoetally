import 'package:commerce_mobile/components/customer_component.dart';
import 'package:commerce_mobile/components/search_component.dart';
import 'package:commerce_mobile/controllers/customerController.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';
import 'package:flutter/material.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:toastification/toastification.dart';
import 'edit_customer.dart'; // Import the EditCustomer page
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  // List<Customers> _filteredCustomers = [];
  String _searchText = "";
  bool _isLoading = true; // Add loading state
  List<Customers> _fetchedCustomers = []; // Holds fetched data
  final CustomerController _customerController =
      CustomerController(); // Instantiate the controller

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> showConfirmationDeleteDialog(
      BuildContext context, Customers customer) {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Customize border radius
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Confirmation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                    'Are you sure you want to remove ${customer.name} as your customer?'),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('Remove'),
                      onPressed: () async {
                        await _customerController
                            .deleteCustomer(customer)
                            .then((value) {
                          toastification.show(
                            context:
                                context, // optional if you use ToastificationWrapper
                            title: Text(
                              'Customer Removed Sucessfully!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900]),
                            ),
                            description:
                                Text('You successfully removed a customer.'),
                            borderRadius: BorderRadius.circular(10),
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green[900],
                            ),
                            type: ToastificationType.success,
                            style: ToastificationStyle.flatColored,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.pushNamed(context, '/customer-list');
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fetch customers using the CustomerController
  Future<void> _fetchCustomers() async {
    List<Customers> customers =
        await _customerController.getAllCustomers(); // Fetch from controller
    setState(() {
      _fetchedCustomers = customers; // Store fetched data
      _isLoading = false; // Stop loading
    });
  }

  // Filter customers based on search input
  List<Customers> _getFilteredCustomers() {
    if (_searchText.isEmpty) {
      return _fetchedCustomers; // Return full list if no search
    } else {
      return _fetchedCustomers
          .where((customer) =>
              customer.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList(); // Filtered list based on search text
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Customers> filteredCustomers =
        _getFilteredCustomers(); // Get filtered customers

    return Scaffold(
      appBar: const CustomAppBar(title: "Customer List"),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : Column(
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
                SearchBarComponent(onChanged: (text) {
                  setState(() {
                    _searchText = text; // Update search text
                  });
                }),
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      return CustomerComponent(
                        name: filteredCustomers[index].name,
                        phoneNumber: filteredCustomers[index].phone_number,
                        onEdit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditCustomer(
                                  customer: filteredCustomers[
                                      index], // Pass the entire customer object
                                ),
                              ));
                        },
                        onDelete: () {
                          showConfirmationDeleteDialog(
                              context, filteredCustomers[index]);
                          // setState(() {
                          //   _fetchedCustomers.remove(
                          //       filteredCustomers[index]); // Remove customer
                          // });
                        },
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
