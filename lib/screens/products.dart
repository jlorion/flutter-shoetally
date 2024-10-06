import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/buttonIcon.dart';
import 'package:commerce_mobile/components/navbar.dart';
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
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    populateProduct();
    print(_filteredTransactions);
  }

  void populateProduct() async {
    final prodcutsList = await ProductControllers().getProducts();
    setState(() {
      _filteredTransactions = prodcutsList;
    });
  }

  void _filterTransactions(String searchText) async {
    final productList = await ProductControllers().getProducts();
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredTransactions =
            productList; // Reset to full list if search is empty
      } else {
        _filteredTransactions = productList
            .where((product) =>
                product.name!.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    populateProduct();
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
                        ListTile(
                          title: Text(
                            _filteredTransactions[index]['title']!,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 98, 54, 155),
                            ),
                          ),
                          subtitle: Text(
                            _filteredTransactions[index]['dateTime']!,
                            style: GoogleFonts.inter(fontSize: 11),
                          ),
                          trailing: Text(
                            "${_filteredTransactions[index]['price']} / Unit",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 98, 54, 155),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
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
