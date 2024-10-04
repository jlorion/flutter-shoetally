import 'package:commerce_mobile/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/inputfields.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController customerNameTextField = TextEditingController();
  TextEditingController customerAddressTextField = TextEditingController();
  TextEditingController customerPhoneTextField = TextEditingController();

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
                    controllerTextField: customerNameTextField),
                const SizedBox(height: 15),
                InputFields(
                    label: 'Address',
                    hintText: 'Address of the Customer',
                    controllerTextField: customerAddressTextField),
                const SizedBox(height: 15),
                InputFields(
                    label: 'Phone Number',
                    hintText: 'Phone Number of the Customer',
                    controllerTextField: customerPhoneTextField),
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
