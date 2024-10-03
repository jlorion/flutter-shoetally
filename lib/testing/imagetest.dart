

// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  
  Future<void> fetchImages() async{
    await Provider.of<StorageService>(context,listen: false).fetchImages();

  }

  @override
  Widget build(BuildContext context) {
    final List<Product> product = ProductSeeder().productListSeed();
    return Consumer<StorageService>(
      builder: (context, storageService, widget) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> storageService.updloadImage(product[Random().nextInt(10)].name),
          child: const Icon(Icons.add),
          ),

      )

    );
  }
}