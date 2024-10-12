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
  void populateProduct() async{
    // final data = await ProductControllers().getProducts();
    List<Product> data  = ProductSeeder().productListSeed();
    setState(() {
      products = data;
      _filteredOrders = products;
    });
  }

  void _filterOrders(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredOrders = products;
      } else {
        _filteredOrders = products
            .where((product) => product.name
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
                    Navigator.pushNamed(context, '/order-list', arguments: chosenProducts);
                  },
                ),
              ],
            ),
          ),
           SearchBarComponent(
              onChanged: _filterOrders), // Add search bar
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final product = _filteredOrders[index];
                return OrderItemComponent(
                  imageUrl: product.image,
                  shoeName: product.name,
                  stockCount: product.product_stock.toString(),
                  onCartPressed: () {
                    setState(() {
                      if (!chosenProducts.contains(product)) {
                        chosenProducts.add(product);
                        print(chosenProducts.length);
                      }else{
                        //error thing "product already on cart"
                        print("product already on cart");
                      }
                    });
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
