import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/controllers/customerController.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';
import 'package:flutter/material.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:toastification/toastification.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController customerNameTextField = TextEditingController();
  TextEditingController customerAddressTextField = TextEditingController();
  TextEditingController customerPhoneTextField = TextEditingController();

  bool _nameError = false;
  bool _addressError = false;
  bool _phoneError = false;

  Future<void> showConfirmationDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                Text('Are you sure you want to add this customer?'),
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
                      child: Text('Add'),
                      onPressed: () async {
                        Customers customer = Customers(
                            name: customerNameTextField.text,
                            phone_number: customerPhoneTextField.text,
                            address: customerAddressTextField.text,
                            id: '');

                        await CustomerController()
                            .addCustomer(customer)
                            .then((value) {
                          toastification.show(
                            context: context,
                            title: Text(
                              'Customer Added Successfully!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900]),
                            ),
                            description:
                                Text('You successfully added a customer.'),
                            borderRadius: BorderRadius.circular(10),
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green[900],
                            ),
                            type: ToastificationType.success,
                            style: ToastificationStyle.flatColored,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.of(context).pop();
                        });

                        customerNameTextField.clear();
                        customerPhoneTextField.clear();
                        customerAddressTextField.clear();
                        Navigator.pushNamed(context, '/customer-list');
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

  void _validateAndSubmit() {
    setState(() {
      _nameError = customerNameTextField.text.isEmpty;
      _addressError = customerAddressTextField.text.isEmpty;
      _phoneError = customerPhoneTextField.text.isEmpty;
    });

    if (!_nameError && !_addressError && !_phoneError) {
      showConfirmationDialog(context);
    } else {
      toastification.show(
        context: context,
        title: Text(
          'Validation Error',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        description: Text('Please fill out all fields.'),
        borderRadius: BorderRadius.circular(10),
        icon: Icon(Icons.error_outline, color: Colors.red),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputFields(
                    label: 'Name',
                    hintText: 'Name of the Customer',
                    controllerTextField: customerNameTextField,
                    borderColor: _nameError ? Colors.red : Colors.black45,
                  ),
                  const SizedBox(height: 15),
                  InputFields(
                    label: 'Address',
                    hintText: 'Address of the Customer',
                    controllerTextField: customerAddressTextField,
                    borderColor: _addressError ? Colors.red : Colors.black45,
                  ),
                  const SizedBox(height: 15),
                  InputFields(
                    label: 'Phone Number',
                    hintText: 'Phone Number of the Customer',
                    controllerTextField: customerPhoneTextField,
                    borderColor: _phoneError ? Colors.red : Colors.black45,
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90.0),
                    child: Center(
                      child: CustomButton(
                        onPressed: _validateAndSubmit,
                        text: 'Add Customer',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
