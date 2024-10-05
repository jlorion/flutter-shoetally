import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/order_item.dart';
import 'package:commerce_mobile/components/search_component.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, String>> orders = [
    {
      'imageUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', // Example image from Flutter library
      'shoeName': 'Air Jordans 1 High',
      'stockCount': '50',
    },
    {
      'imageUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', // Another Flutter example image
      'shoeName': 'Kob NIKE Precision',
      'stockCount': '0',
    },
    {
      'imageUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-3.jpg', // Flutter sample image for cards
      'shoeName': 'Savoy Adidas',
      'stockCount': '99',
    },
  ];

  List<Map<String, String>> _filteredOrders = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _filteredOrders = orders;
  }

  void _filterOrders(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredOrders = orders;
      } else {
        _filteredOrders = orders
            .where((transaction) => transaction['title']!
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Orders"),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButtonComponent(),
                const Spacer(),
                IconButtonComponent(
                  buttonText: 'Order List',
                  onPressed: () {
                    Navigator.pushNamed(context, '/order-list');
                  },
                ),
              ],
            ),
          ),
           SearchBarComponent(
              onChanged: _filterOrders), // Add search bar
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderItemComponent(
                  imageUrl: order['imageUrl']!,
                  shoeName: order['shoeName']!,
                  stockCount: order['stockCount']!,
                  onCartPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added to cart'),
                      ),
                    );
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
