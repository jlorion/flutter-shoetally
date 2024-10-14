import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/custom_button.dart'; // Ensure this path is correct
import 'package:commerce_mobile/components/dropdownbuttonform.dart';
import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/current_order.dart';
import 'package:commerce_mobile/controllers/Product_Controllers.dart';
import 'package:commerce_mobile/controllers/Transaction_Contorller.dart';
import 'package:commerce_mobile/controllers/customerController.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';
import 'package:commerce_mobile/models/OrdersModel.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:commerce_mobile/models/UserModel.dart';
import 'package:commerce_mobile/models/UserProfile.dart';
import 'package:commerce_mobile/screens/receipt.dart';
import 'package:commerce_mobile/services/authentication/auth_functions.dart';
import 'package:commerce_mobile/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  User? user;
  Userprofile? userprofile;
  List<Map<String, dynamic>> _orders = [];
  List<Customers> customerList = [];
  Encapsulation productName = Encapsulation();

  bool customerError = false;

  Future<void> _loadUserData() async {
    user = await AuthFunctions().getCurrentUser();
    if (user != null) {
      final profile = await AuthenticationService().getUserProfile(user);
      setState(() {
        userprofile = profile;
      });
    }
  }

  void populateCustomer() async {
    final customers = await CustomerController().getAllCustomers();
    setState(() {
      customerList = customers;
    });
  }

  double _getSubtotal() {
    return _orders
        .where((item) => item['quantity'] > 0)
        .fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  double _getTotalProfit() {
    return _orders.fold(0.0, (sum, item) {
      return sum + (item['profit'] * item['quantity']);
    });
  }

  double _getTax() {
    return _getSubtotal() * 0.12; // 12% tax
  }

  double _getShipping() {
    return 139.50; // Static shipping cost
  }

  double _getTotal() {
    return _getSubtotal() + _getTax() + _getShipping();
  }

  void _increaseQuantity(int index) {
    if (_orders[index]['stock']> 0) {
      setState(() {
        _orders[index]['quantity'] += 1;
        _orders[index]['stock'] -= 1;
      });
    }
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (_orders[index]['quantity'] > 1) {
        _orders[index]['quantity'] -= 1;
        _orders[index]['stock'] += 1;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _orders.removeAt(index);
    });
  }

  void _validateAndSubmit() {
    setState(() {
      customerError = productName.text?.isEmpty ?? true;
    });

    if (!customerError) {
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
                Text('Are you sure you want to checkout?'),
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
                      child: Text('Checkout'),
                      onPressed: () async {
                        Transactions trans = Transactions(
                          id: '',
                          customer_name: productName.text ?? '',
                          total_amount: _getTotal(),
                          total_profit: _getTotalProfit(),
                          date_time: DateTime.now().toString(),
                          user_name: userprofile?.name ?? '',
                        );

                        List<Orders> finalOrders = _orders
                            .map((prod) => Orders(
                                  id: '',
                                  product_name: prod['productName'],
                                  productImage: prod['imageUrl'],
                                  total_price: prod['price'],
                                  quantity: prod['quantity'],
                                ))
                            .toList();

                        // Add product function
                        String id = await TransactionContorller()
                            .addTransaction(trans, finalOrders);

                        // Update product quantities after successful transaction
                        for (var orders in _orders) {
                          print(orders['stock'].toString() + "--- this is the stock");
                          print(orders['quantity'].toString());
                          await ProductControllers().updateProductStock(orders["productId"], orders['stock']);
                        }

                        double finalVal = _getTotal();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Receipt(stringId: id, total_amount: finalVal, trans: trans,),
                          ),
                        );
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => populateOrders());
    populateCustomer();
    _loadUserData();
  }

  void populateOrders() async {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      setState(() {
        final list = args as List<Product>;
        _orders = list
            .map((product) => {
                  'imageUrl': product.image,
                  'productName': product.name,
                  'productId': product.id,
                  'price': product.selling_price,
                  'profit': product.profit, // Include profit here
                  'quantity': 1,
                  'stock': product.product_stock - 1
                })
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Orders"),
      drawer: const AppDrawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButtonComponent(),
            const Text(
              'Current Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _orders.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return CurrentOrder(
                    imageUrl: order['imageUrl'],
                    productName: order['productName'],
                    productId: order['stock'].toString(), // Fix here
                    price: order['price'],
                    quantity: order['quantity'],
                    onIncrease: () => _increaseQuantity(index),
                    onDecrease: () => _decreaseQuantity(index),
                    onRemove: () => _removeItem(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildOrderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 16),
        DropdownField(
          label: 'Customer',
          hintText: 'customer name',
          items: customerList.map((x) => x.name).toList(),
          selectedValue: productName,
          borderColor: customerError ? Colors.red : Colors.black26,
        ),
        const SizedBox(height: 16),
        _buildSummaryRow(
            'Subtotal', 'PHP ${_getSubtotal().toStringAsFixed(2)}'),
        _buildSummaryRow(
            'Estimated Tax', 'PHP ${_getTax().toStringAsFixed(2)}'),
        _buildSummaryRow('Estimated Shipping & Handling',
            'PHP ${_getShipping().toStringAsFixed(2)}'),

        _buildSummaryRow('Total Profit',
            'PHP ${_getTotalProfit().toStringAsFixed(2)}'), // Display total profit here

        _buildSummaryRow('Total', 'PHP ${_getTotal().toStringAsFixed(2)}',
            isBold: true),
        const SizedBox(height: 16),
        CustomButton(
          onPressed: _orders.isEmpty
              ? () {}
              : () {
                  _validateAndSubmit();
                },
          text: 'Checkout',
          isEnabled: _orders.isNotEmpty,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
