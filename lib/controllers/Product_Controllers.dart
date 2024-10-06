

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/components/encapsulation.dart';
import 'package:commerce_mobile/models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:commerce_mobile/services/storage_service.dart';

class ProductControllers {

  CollectionReference ref = FirebaseFirestore.instance.collection('products');
  //post product
  Future<void> postProduct({
    required TextEditingController name,
    required TextEditingController selling_price,
    required TextEditingController total_purchase,
    required TextEditingController product_stock,
    required Encapsulation category,
    required XFile? imagePick,
  }) async {
    String _finalImage = await StorageService().updloadImage(imagePick);
    Product prodPost = Product(
              id: '',
              name: name.text,
              selling_price: double.parse(selling_price.text),
              total_purchase: double.parse(total_purchase.text),
              product_stock: int.parse(product_stock.text),
              category: category.text??'',
              image: _finalImage
    );
    DocumentReference docref = await ref.add(prodPost.toJson());
    await docref.update({
      'id': docref.id,
    });
    
  }
  //delete product
  Future<void> deleteProduct() async {


  }

  //update product
  Future<void> updateProduct(Product prod) async{
    DocumentReference docref = await ref.doc(prod.id);
    docref.update(prod.toJson());
  }


  //get products
  Future<List<Product>> getProducts() async{
    final snapshot = await ref.get();
    return snapshot.docs.map((doc)=> Product.fromFireStore(doc.data() as Map<String, dynamic>, doc.id)).toList();
  }
  
}

// () async {
//                     //upload image and get link
//                     String _finalImage = await storageService.updloadImage(_image);
//                     CollectionReference ref = FirebaseFirestore.instance.collection('products');
//                     //upload to firestore with Prdouct Model
//                     Product prodPost = Product(
//                         id: '',
//                         name: _name.text,
//                         selling_price: double.parse(_selling_price.text),
//                ?         total_purchase: double.parse(_total_purchase.text),
//                ?         product_stock: int.parse(_product_stock.text),
//                ?         category: _category.text,
//                ?         image: _finalImage);
//                     DocumentReference docref  = await ref.add(prodPost.toJson());
//                     await docref.update({
//                       'id': docref.id,
//                     });
