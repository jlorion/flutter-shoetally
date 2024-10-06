// import 'package:commerce_mobile/compontents/inputfields.dart';
// import 'package:commerce_mobile/controllers/customerController.dart';
// import 'package:commerce_mobile/models/CustomersModel.dart';
// import 'package:flutter/material.dart';

// class AddCustomer extends StatefulWidget {
//   const AddCustomer({super.key});

//   @override
//   State<AddCustomer> createState() => _AddCustomerState();
// }

// class _AddCustomerState extends State<AddCustomer> {
//   TextEditingController customerNameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InputFields(
//                   label: 'Customer Name',
//                   hintText: 'Enter the customer name',
//                   controllerTextField: customerNameController),
//               const SizedBox(height: 20),
//               InputFields(
//                   label: 'Phone Number',
//                   hintText: 'Enter the phone number',
//                   controllerTextField: phoneNumberController),
//               const SizedBox(height: 20),
//               InputFields(
//                   label: 'Address',
//                   hintText: 'Enter the address',
//                   controllerTextField: addressController),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                   onPressed: () async {
//                     Customers customer = Customers(
//                         name: customerNameController.text,
//                         phone_number: phoneNumberController.text,
//                         address: addressController.text,
//                         id: '');

//                     await CustomerController().addCustomer(customer);

//                     customerNameController.clear();
//                     phoneNumberController.clear();
//                     addressController.clear();
//                   },
//                   child: Text("Add Customer"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
