import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentOrder extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productId;
  final double price;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CurrentOrder({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Product Image
        Image.network(
          imageUrl,
          height: 80,
          width: 110,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 25),

        // Product Name and ID

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              Text(
                productId,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                '₱ ${price * quantity}',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFA259FF),
                ),
              ),
              Row(
                children: [
                  // Disable Decrease button if quantity is zero
                  IconButton(
                    onPressed: quantity == 0 ? null : onDecrease,
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$quantity'),
                  IconButton(
                    onPressed: onIncrease,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.close, size: 20),
        ),
      ],
    );
  }
}
