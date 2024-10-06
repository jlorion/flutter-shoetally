import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/dropdownbuttonform.dart';
import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker
import 'package:dotted_border/dotted_border.dart'; // Import dotted_border

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productNameTextField = TextEditingController();
  TextEditingController sellingPriceTextField = TextEditingController();
  TextEditingController totalPurchaseTextField = TextEditingController();
  TextEditingController quantityTextField = TextEditingController();
  TextEditingController descriptionTextField = TextEditingController();
  Encapsulation encap = Encapsulation();

  final String _selectedCategory = 'shoes';

  // Add file variable to store selected file
  String? _selectedFile;

  // Function to handle file picking
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'mp4'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Product"),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonComponent(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFields(
                        label: 'Name',
                        hintText: 'Name of the product',
                        controllerTextField: productNameTextField),
                    const SizedBox(height: 15),
                    InputFields(
                        label: 'Selling Price',
                        hintText: "Enter the product's price",
                        controllerTextField: sellingPriceTextField),
                    const SizedBox(height: 15),
                    InputFields(
                        label: 'Total Purchase',
                        hintText: 'Enter the purchasing price',
                        controllerTextField: totalPurchaseTextField),
                    const SizedBox(height: 15),
                    InputFields(
                        label: 'Quantity',
                        hintText: 'Enter the quantity',
                        controllerTextField: quantityTextField),
                    const SizedBox(height: 15),
                    DropdownField(
                      label: 'Category',
                      hintText: 'Select a category',
                      items: const ['shoes', 'slippers', 'food', 'vehicles'],
                      selectedValue: encap,
                    ),
                    const SizedBox(height: 15),
                    InputFields(
                        label: 'Description',
                        hintText: 'Enter the product description',
                        controllerTextField: descriptionTextField),
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: _pickFile, // file picker on tap
                      child: DottedBorder(
                        color: const Color(0xFF766789),
                        strokeWidth: 2,
                        dashPattern: const [10, 10], // spacing
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: _selectedFile == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cloud_upload_outlined,
                                        size: 30, color: Colors.grey),
                                    Text(
                                      "Choose a file or drag & drop it here",
                                      style: TextStyle(
                                        color: Color(0xFF766789),
                                      ),
                                    ),
                                    Text(
                                        "JPEG, PNG, PDG, MP4 formats, up to 50MB",
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                )
                              : Text(
                                  _selectedFile!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Center(
                        child: CustomButton(
                          onPressed: () {
                            // add product function
                          },
                          text: 'Edit Product',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
