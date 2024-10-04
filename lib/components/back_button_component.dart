import 'package:flutter/material.dart';

class BackButtonComponent extends StatelessWidget {
  final VoidCallback? onTap; // Allows a custom onTap if needed

  const BackButtonComponent({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => Navigator.pop(context), // Default action: pop the screen
      child: const Row(
        children: [
          Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
          SizedBox(width: 2.0),
          Text(
            'Back',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFFA259FF),
            ),
          ),
        ],
      ),
    );
  }
}
