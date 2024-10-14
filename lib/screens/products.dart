import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
import 'package:commerce_mobile/components/productcard.dart';
import 'package:commerce_mobile/components/search_component.dart';
import 'package:commerce_mobile/controllers/Product_Controllers.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product> _filteredTransactions = [];
  List<Product> _allProducts = []; // Full list of products for filtering
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    populateProduct();
  }

  void populateProduct() async {
    final productList = await ProductControllers().getProducts();

    // Sort the products by stock in descending order
    productList.sort((a, b) => b.product_stock.compareTo(a.product_stock));

    setState(() {
      _allProducts = productList; // Store the full list of products
      _filteredTransactions = _allProducts; // Show all products initially
    });
  }

  void _filterTransactions(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredTransactions =
            _allProducts; // Reset to full list if search is empty
      } else {
        // Perform filtering
        _filteredTransactions = _allProducts
            .where((product) =>
                product.name!.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Products"),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButtonComponent(),
                const Spacer(),
                IconButtonComponent(
                  buttonText: 'Add Product',
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-product');
                    print('Add Product button pressed');
                  },
                ),
              ],
            ),
          ),
          SearchBarComponent(onChanged: _filterTransactions),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProductCard(
                          filteredTransactions: _filteredTransactions,
                          index: index,
                        ),
                      ],
                    ),
                  ),
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
