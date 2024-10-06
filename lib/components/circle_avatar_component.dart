import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleAvatarComponent extends StatefulWidget {
  const CircleAvatarComponent({Key? key}) : super(key: key);

  @override
  _CircleAvatarComponentState createState() => _CircleAvatarComponentState();
}

class _CircleAvatarComponentState extends State<CircleAvatarComponent> {
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage, // Pick image when avatar is tapped
      child: CircleAvatar(
        radius: 70,
        backgroundImage:
            _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
        child: _imageFile == null
            ? const Icon(Icons.person, size: 50) // Default icon if no image
            : null,
      ),
    );
  }
}
