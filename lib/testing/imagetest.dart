// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:commerce_mobile/services/storage_service.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:commerce_mobile/seeders/product_seeder.dart';

class Imagetest extends StatefulWidget {
  const Imagetest({super.key});

  @override
  State<Imagetest> createState() => _ImagetestState();
}

class _ImagetestState extends State<Imagetest> {
  XFile? _image;
  final List<Product> product = ProductSeeder().productListSeed();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _selling_price = TextEditingController();
  final TextEditingController _total_purchase = TextEditingController();
  final TextEditingController _product_stock = TextEditingController();
  final TextEditingController _category = TextEditingController();
  String _finalImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, widget) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() async {
            _image = await storageService.selectImage();
          }),
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: 'NAME'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _selling_price,
              decoration: InputDecoration(labelText: 'Selling Price'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _total_purchase,
              decoration: InputDecoration(labelText: 'Total Purchase'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _product_stock,
              decoration: InputDecoration(labelText: 'Product Stock'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _category,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(
              height: 10,
            ),
            //abstract this to a function becuase fuck this piece of shit
            _image != null
                ? kIsWeb
                    ? Image.network(_image!.path)
                    : Image.file(File(_image!.path))
                : Text('No Image Selected'),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    //this is selec image
                    final imageSelected = await storageService.selectImage();
                    setState(() {
                      _image = imageSelected;
                    });
                  },
                  child: Icon(Icons.post_add)),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    //upload image and get link
                    _finalImage = await storageService.updloadImage(_image);
                    CollectionReference ref = FirebaseFirestore.instance.collection('products');
                    //upload to firestore with Prdouct Model
                    Product prodPost = Product(
                        id: '',
                        name: _name.text,
                        selling_price: double.parse(_selling_price.text),
                        total_purchase: double.parse(_total_purchase.text),
                        product_stock: int.parse(_product_stock.text),
                        category: _category.text,
                        image: _finalImage);
                    DocumentReference docref  = await ref.add(prodPost.toJson());
                    await docref.update({
                      'id': docref.id,
                    });
                  },
                  child: Icon(Icons.send)),
            )
          ],
        ),
        //Image.network(imageurl)
      ),
    );
  }
}
