import 'package:flutter/material.dart';

class CustomerComponent extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final VoidCallback onDelete;
  final VoidCallback onEdit; // Add the onEdit callback

  const CustomerComponent({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.onDelete,
    required this.onEdit, // Add the onEdit callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
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
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 98, 54, 155),
            ),
          ),
          subtitle: Text(phoneNumber),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit), // Edit icon
                onPressed: onEdit, // Call onEdit when clicked
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete, // Call onDelete when clicked
              ),
            ],
          ),
        ),
      ),
    );
  }
}
