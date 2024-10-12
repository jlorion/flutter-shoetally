import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/dropdownbuttonform.dart';
import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/current_order.dart'; // Import your new component
import 'package:commerce_mobile/controllers/Transaction_Contorller.dart';
import 'package:commerce_mobile/controllers/customerController.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';
import 'package:commerce_mobile/models/OrdersModel.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';
import 'package:commerce_mobile/models/UserModel.dart';
import 'package:commerce_mobile/screens/receipt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key? key,}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();

}

class _OrderListPageState extends State<OrderListPage> {

  List<Map<String, dynamic>> _orders = [];
  List<Customers> customerList = [];
  Encapsulation productName = Encapsulation();
  // final user = FirebaseAuth.instance.currentUser;
  // User userAcc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

  void populateCustomer() async{
    final customers = await CustomerController().getAllCustomers();
    setState(() {
      customerList = customers;
    });
  }

  // Calculate the subtotal based on orders with a quantity > 0
  double _getSubtotal() {
    return _orders
        .where((item) => item['quantity'] > 0)
        .fold(0, (sum, item) => sum + item['price'] * item['quantity']);
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
    setState(() {
      _orders[index]['quantity'] += 1;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (_orders[index]['quantity'] > 0) {
        _orders[index]['quantity'] -= 1;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _orders.removeAt(index);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=> populateOrders());
    populateCustomer();
    
  }

  
  void populateOrders() {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
      setState(() {
        final list = args as List<Product>;
        _orders = list.map((product)=> {
          'imageUrl': product.image,
          'productName': product.name,
          'productId': product.id,
          'price': product.selling_price,
          'quantity': 1 
        }).toList();
      });
      }
    }

  @override
  Widget build(BuildContext context) {
    print(_orders);
    return Scaffold(
      appBar: const CustomAppBar(title: "Orders"),
      drawer: const AppDrawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Adjust the color to match the design
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
                    productId: order['productId'],
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
            color: Colors.purple, // Adjust to match the design
          ),
        ),
        const SizedBox(height: 16),
        DropdownField(label: 'Customer', hintText: 'customer name', items: customerList.map((x)=> x.name).toList(), selectedValue: productName),
        const SizedBox(height: 16),
        _buildSummaryRow(
            'Subtotal', 'PHP ${_getSubtotal().toStringAsFixed(2)}'),
        _buildSummaryRow(
            'Estimated Tax', 'PHP ${_getTax().toStringAsFixed(2)}'),
        _buildSummaryRow('Estimated shipping & Handling',
            'PHP ${_getShipping().toStringAsFixed(2)}'),
        const SizedBox(height: 16),
        _buildSummaryRow(
          'Total',
          'PHP ${_getTotal().toStringAsFixed(2)}',
          isBold: true,
        ),
        const SizedBox(height: 16),
        CustomButton(
          onPressed: () {
            Transactions trans = Transactions(id: '', customer_name: productName.text??'', total_amount: _getTotal(), date_time: DateTime.now().toString(), user_name: 'shit');
            List<Orders> finalOrders = _orders.map((prod)=> Orders(id: '', product_name: prod['productName'], productImage: prod['imageUrl'], total_price: prod['price'], quantity: prod['quantity'])).toList();
            // add product function
            TransactionContorller().addTransaction(trans, finalOrders);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Receipt()),
            );
          },
          text: 'Checkout',
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
