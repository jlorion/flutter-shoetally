import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/order_item.dart';
import 'package:commerce_mobile/components/search_component.dart';
import 'package:commerce_mobile/controllers/Product_Controllers.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/seeders/product_seeder.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Product> products = [];

  List<Product> _filteredOrders = [];
  List<Product> chosenProducts = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    populateProduct();
  }

  void populateProduct() async {
    final data = await ProductControllers().getProducts();
    // Sort products based on stock count from highest to lowest
    data.sort((a, b) => b.product_stock.compareTo(a.product_stock));
    setState(() {
      products = data;
      _filteredOrders = products;
    });
  }

  void _filterOrders(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        // Sort the filtered products by stock count as well
        _filteredOrders = products;
      } else {
        _filteredOrders = products
            .where((product) =>
                product.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
        // Sort filtered products by stock count
        _filteredOrders
            .sort((a, b) => b.product_stock.compareTo(a.product_stock));
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
                    Navigator.pushNamed(context, '/order-list',
                        arguments: chosenProducts);
                  },
                ),
              ],
            ),
          ),
          SearchBarComponent(onChanged: _filterOrders), // Add search bar
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final product = _filteredOrders[index];

                // Determine the title color based on the stock
                Color titleColor;
                if (product.product_stock == 0) {
                  titleColor = Colors.red; // Red for zero stock
                } else if (product.product_stock < 5) {
                  titleColor =
                      Colors.yellow.shade900; // Yellow for less than 5 stock
                } else {
                  titleColor =
                      Colors.black; // Default color for sufficient stock
                }

                return OrderItemComponent(
                  imageUrl: product.image,
                  shoeName: product.name,
                  profit: product.profit,
                  stockCount: product.product_stock.toString(),
                  titleColor: titleColor, // Pass the determined color
                  onCartPressed: () {
                    if (product.product_stock <= 0) {
                      toastification.show(
                        context: context,
                        title: Text(
                          'Insufficient Stocks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        description: Text('${product.name} needs restocking.'),
                        borderRadius: BorderRadius.circular(10),
                        icon: Icon(Icons.error_outline, color: Colors.red),
                        type: ToastificationType.error,
                        style: ToastificationStyle.flatColored,
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    } else {
                      setState(() {
                        if (!chosenProducts.contains(product)) {
                          chosenProducts.add(product);
                          print(chosenProducts.length);
                        } else {
                          print("product already on cart");
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product added to cart'),
                        ),
                      );
                    }
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
