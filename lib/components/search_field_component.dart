import 'package:flutter/material.dart';

class SearchFieldComponent extends StatelessWidget {
  final Function(String) onChanged; // Callback function to handle the search input

  const SearchFieldComponent({
    Key? key,
    required this.onChanged, // This will be used to pass the onChanged functionality
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: onChanged, // Pass the function to the TextField
        style: const TextStyle(
          color: Color(0xFF9586A8), // Set the text color here
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFA259FF), // Set the icon color here
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
