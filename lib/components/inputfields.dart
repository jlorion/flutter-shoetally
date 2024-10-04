import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFields extends StatefulWidget {
  final String label;

  final String hintText;

  final TextEditingController controllerTextField;

  const InputFields({
    super.key,
    required this.label,
    required this.hintText,
    required this.controllerTextField,
  });

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF766789),
          ),
        ),
        TextField(
          controller: widget.controllerTextField,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w300,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 223, 223, 223), // grey color for enabled border
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: Color(0xFF6C3AAC), // purple color for focused border
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, // increase height
              horizontal: 15.0, // add horizontal padding
            ),
          ),
        )
      ],
    );
  }
}
