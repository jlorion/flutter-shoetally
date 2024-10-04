import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: CustomButtonStyle.elevatedButtonStyle(),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

class CustomButtonStyle {
  static ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFFA259FF),
      minimumSize: const Size.fromHeight(60),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
