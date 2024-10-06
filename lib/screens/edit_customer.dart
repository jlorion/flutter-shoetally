import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:commerce_mobile/controllers/customerController.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart'; // Import toastification package

class EditCustomer extends StatefulWidget {
  final Customers customer; // Pass the entire customer object

  const EditCustomer({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  CustomerController _customerController = CustomerController();

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;

  bool _nameError = false;
  bool _addressError = false;
  bool _phoneNumberError = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _addressController = TextEditingController(text: widget.customer.address);
    _phoneNumberController =
        TextEditingController(text: widget.customer.phone_number);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _updateCustomer() {
    setState(() {
      _nameError = _nameController.text.isEmpty;
      _addressError = _addressController.text.isEmpty;
      _phoneNumberError = _phoneNumberController.text.isEmpty;
    });

    // Check if there are any errors
    if (!_nameError && !_addressError && !_phoneNumberError) {
      showConfirmationUpdateDialog(context, widget.customer);
    } else {
      // Show toast messages for empty fields
      String errorMessage = 'Please fill out the all the fields.';

      toastification.show(
        context: context,
        title: Text(
          'Input Error',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        description: Text(errorMessage),
        borderRadius: BorderRadius.circular(10),
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> showConfirmationUpdateDialog(
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
                Text('Are you sure you want to update this customer?'),
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
                      child: Text('Update'),
                      onPressed: () async {
                        Customers customer = Customers(
                          name: _nameController.text,
                          phone_number: _phoneNumberController.text,
                          address: _addressController.text,
                          id: widget.customer.id,
                        );

                        await _customerController
                            .editCustomer(customer)
                            .then((value) {
                          toastification.show(
                            context: context,
                            title: Text(
                              'Customer Updated Successfully!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900]),
                            ),
                            description:
                                Text('You successfully updated a customer.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Customer"),
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
                  controllerTextField: _nameController,
                  borderColor: _nameError ? Colors.red : Colors.grey,
                ),
                const SizedBox(height: 15),
                InputFields(
                  label: 'Address',
                  hintText: 'Address of the Customer',
                  controllerTextField: _addressController,
                  borderColor: _addressError ? Colors.red : Colors.grey,
                ),
                const SizedBox(height: 15),
                InputFields(
                  label: 'Phone Number',
                  hintText: 'Phone Number of the Customer',
                  controllerTextField: _phoneNumberController,
                  borderColor: _phoneNumberError ? Colors.red : Colors.grey,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Center(
                    child: CustomButton(
                      onPressed: _updateCustomer, // Call the update function
                      text: 'Update',
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
