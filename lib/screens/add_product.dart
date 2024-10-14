import 'dart:io';
import 'package:commerce_mobile/components/app_drawer.dart';
import 'package:commerce_mobile/components/appbar.dart';
import 'package:commerce_mobile/components/back_button_component.dart';
import 'package:commerce_mobile/components/custom_button.dart';
import 'package:commerce_mobile/components/dropdownbuttonform.dart';
import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:commerce_mobile/components/inputfields.dart';
import 'package:commerce_mobile/controllers/Product_Controllers.dart';
import 'package:commerce_mobile/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart'; // Import dotted_border
import 'package:toastification/toastification.dart'; // Import dotted_border

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? _image;
  TextEditingController productNameTextField = TextEditingController();
  TextEditingController sellingPriceTextField = TextEditingController();
  TextEditingController totalPurchaseTextField = TextEditingController();
  TextEditingController quantityTextField = TextEditingController();

  Encapsulation encap = Encapsulation();

  bool productNameError = false;
  bool sellingError = false;
  bool purchaseError = false;
  bool quantityError = false;
  bool categoryError = false;
  bool encapError = false;
  bool profitError = false;

  void _validateAndSubmit() {
    setState(() {
      productNameError = productNameTextField.text.isEmpty;
      sellingError = sellingPriceTextField.text.isEmpty;
      purchaseError = totalPurchaseTextField.text.isEmpty;
      quantityError = quantityTextField.text.isEmpty;
      encapError = encap.text?.isEmpty ?? true;
      profitError = (double.parse(sellingPriceTextField.text) <=
              double.parse(totalPurchaseTextField.text))
          ? true
          : false;
    });

    if (profitError) {
      toastification.show(
        context: context,
        title: Text(
          'No Profit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        description:
            Text('Selling price must be greater than the purchase price.'),
        borderRadius: BorderRadius.circular(10),
        icon: Icon(Icons.error_outline, color: Colors.red),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      if (!productNameError &&
          !sellingError &&
          !purchaseError &&
          !quantityError &&
          !encapError) {
        showConfirmationDialog(context);
      } else {
        toastification.show(
          context: context,
          title: Text(
            'Validation Error',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          description: Text('Please fill out all fields.'),
          borderRadius: BorderRadius.circular(10),
          icon: Icon(Icons.error_outline, color: Colors.red),
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    }
  }

  Future<void> showConfirmationDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Confirmation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Are you sure you want to add this product?'),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    SizedBox(width: 8),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () async {
                        await ProductControllers()
                            .postProduct(
                          name: productNameTextField,
                          selling_price: sellingPriceTextField,
                          total_purchase: totalPurchaseTextField,
                          product_stock: quantityTextField,
                          category: encap,
                          imagePick: _image,
                          // profit: double.parse(sellingPriceTextField.text) -
                          //     double.parse(totalPurchaseTextField.text),
                        )
                            .then((value) {
                          toastification.show(
                            context: context,
                            title: Text(
                              'Product Added Successfully!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900]),
                            ),
                            description:
                                Text('You successfully added a product.'),
                            borderRadius: BorderRadius.circular(10),
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green[900],
                            ),
                            type: ToastificationType.success,
                            style: ToastificationStyle.flatColored,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.of(context).pop();
                        });

                        productNameTextField.clear();
                        sellingPriceTextField.clear();
                        totalPurchaseTextField.clear();
                        quantityTextField.clear();

                        Navigator.pushNamed(context, '/products');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to handle file picking
  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(builder: (context, storageService, widget) {
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
                        controllerTextField: productNameTextField,
                        borderColor:
                            productNameError ? Colors.red : Colors.black26,
                      ),
                      const SizedBox(height: 15),
                      InputFields(
                        label: 'Selling Price',
                        hintText: "Enter the product's price",
                        controllerTextField: sellingPriceTextField,
                        borderColor: (sellingError || profitError)
                            ? Colors.red
                            : Colors.black26,
                      ),
                      const SizedBox(height: 15),
                      InputFields(
                        label: 'Total Purchase',
                        hintText: 'Enter the purchasing price',
                        controllerTextField: totalPurchaseTextField,
                        borderColor: (purchaseError || profitError)
                            ? Colors.red
                            : Colors.black26,
                      ),
                      const SizedBox(height: 15),
                      InputFields(
                        label: 'Quantity',
                        hintText: 'Enter the quantity',
                        controllerTextField: quantityTextField,
                        borderColor:
                            quantityError ? Colors.red : Colors.black26,
                      ),
                      const SizedBox(height: 15),
                      DropdownField(
                        label: 'Category',
                        hintText: 'Select a category',
                        items: const ['shoes', 'slippers', 'food', 'vehicles'],
                        selectedValue: encap,
                        borderColor: encapError ? Colors.red : Colors.black26,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () async {
                          final imageSeleted =
                              await storageService.selectImage();
                          if (imageSeleted != null) {
                            setState(() {
                              _image = imageSeleted;
                              print(encap.text);
                            });
                          }
                        }, // file picker on tap
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
                            child: _image == null
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
                                : kIsWeb
                                    ? Image.network(_image!.path)
                                    : Image.file(File(_image!.path)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Center(
                          child: CustomButton(
                            onPressed: () async => _validateAndSubmit(),
                            text: 'Add Product',
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
    });
  }
}
