import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/screens/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key, required this.filteredTransactions, required this.index});

  final List<Product> filteredTransactions;
  final int index;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Perform action on tap

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProduct(
                      filteredTransactions: widget.filteredTransactions,
                      index: widget.index,
                    )));
        print(
            'InkWell tapped! ${widget.filteredTransactions[widget.index].name}');
      },
      child: ListTile(
        title: Text(
          widget.filteredTransactions[widget.index].name!,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 98, 54, 155),
          ),
        ),
        subtitle: Text(
          'Stocks: ${widget.filteredTransactions[widget.index].product_stock.toString()}',
          style: GoogleFonts.inter(fontSize: 11),
        ),
        trailing: Text(
          "₱ ${widget.filteredTransactions[widget.index].selling_price} / Unit",
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 98, 54, 155),
          ),
        ),
      ),
    );
  }
}
