import 'package:flutter/material.dart';

class PasswordFields extends StatefulWidget {
  const PasswordFields({
    super.key,
    required this.passlabel,
    required this.hintText,
    required this.controllerTextField,
  });

  final String passlabel;
  final String hintText;
  final TextEditingController controllerTextField;

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  bool _showPassword = false;
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controllerTextField,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.black45),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: _showPassword ? Color(0xFF6C3AAC) : Colors.grey,
              ),
              onPressed: () {
                setState(
                  () {
                    _showPassword = !_showPassword;
                  },
                );
              },
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
        ),
      ],
    );
  }
}
