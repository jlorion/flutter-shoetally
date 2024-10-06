import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'References Number',
                    style:
                        TextStyle(fontSize: 16), // Adjust font size as needed
                  ),
                ),
                Text(
                  '000085752257',
                  style: TextStyle(fontSize: 16), // Adjust font size as needed
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
