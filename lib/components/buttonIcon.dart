import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const IconButtonComponent({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFA259FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
