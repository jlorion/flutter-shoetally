import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:flutter/material.dart';

class EditCustomer extends StatefulWidget {
  final String name;
  final String address; // Address field
  final String phoneNumber;

  const EditCustomer({
    Key? key,
    required this.name,
    required this.address, // Pass address to constructor
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  late TextEditingController _nameController;
  late TextEditingController _addressController; // Address controller
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _addressController =
        TextEditingController(text: widget.address); // Initialize with address
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose(); // Dispose address controller
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _saveCustomer() {
    // Handle save customer logic
    final updatedName = _nameController.text;
    final updatedAddress = _addressController.text; // Get updated address
    final updatedPhoneNumber = _phoneNumberController.text;

    // You can add logic here to update the customer in your database or state
    Navigator.pop(context, {
      'name': updatedName,
      'address': updatedAddress, // Return updated address
      'phoneNumber': updatedPhoneNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Customer"),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonComponent(),
                Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputFields(
                    label: 'Name',
                    hintText: 'Name of the Customer',
                    controllerTextField: _nameController),
                const SizedBox(height: 15),
                InputFields(
                    label: 'Address',
                    hintText: 'Address of the Customer',
                    controllerTextField: _addressController),
                const SizedBox(height: 15),
                InputFields(
                    label: 'Phone Number',
                    hintText: 'Phone Number of the Customer',
                    controllerTextField: _phoneNumberController),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 90.0), //mag dictate unsa ka dako ang button
                  child: Center(
                    child: CustomButton(
                      onPressed: () {
                        // add product function
                      },
                      text: 'Add Customer',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
