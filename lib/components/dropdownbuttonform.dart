import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final String hintText;
  final List<String> items;
  final Encapsulation selectedValue;

  final Color borderColor;

  const DropdownField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.items,
      required this.selectedValue,
      this.borderColor = Colors.black45});

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue =
        widget.selectedValue.text; // Initially set to null to show the hint
  }

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
        DropdownButtonFormField<String>(
          value: _currentValue, // Current value is null initially
          hint: Text(
            // Display hint text when no item is selected
            widget.hintText,
            style: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w300,
            ),
          ),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _currentValue = newValue;
              widget.selectedValue.text = newValue;
              widget.selectedValue.text = newValue;
            });
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                color: widget.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: Color(0xFF6C3AAC),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, // increase height
              horizontal: 15.0, // add horizontal padding
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6C3AAC)),
          dropdownColor: Colors.white,
        ),
      ],
    );
  }
}
