import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/current_order.dart'; // Import your new component
import 'package:commerce_mobile/screens/receipt.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  // List of orders with prices and quantities (starting at 0)
  final List<Map<String, dynamic>> _orders = [
    {
      'imageUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'productName': 'Air Jordans 1 High',
      'productId': '#25139526913984',
      'price': 1500.00,
      'quantity': 0, // Start at zero
    },
    {
      'imageUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
      'productName': 'KOB Nike Precision',
      'productId': '#53459358345',
      'price': 2499.00,
      'quantity': 0, // Start at zero
    },
    {
      'imageUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg',
      'productName': 'Savory Adidas',
      'productId': '#1297170700671',
      'price': 999.00,
      'quantity': 0, // Start at zero
    },
  ];

  // Calculate the subtotal based on orders with a quantity > 0
  double _getSubtotal() {
    return _orders
        .where((item) => item['quantity'] > 0)
        .fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  double _getTax() {
    return _getSubtotal() * 0.05; // 5% tax
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
        TextField(
          decoration: const InputDecoration(
            labelText: 'Customer',
            border: OutlineInputBorder(),
          ),
        ),
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
            // add product function
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
