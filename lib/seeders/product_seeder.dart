


import 'dart:convert';

import 'package:commerce_mobile/models/ProductsModel.dart';

class ProductSeeder{

  final String _data = '[{"id":"1","name":"Overhold","selling_price":38.75,"total_purchase":96,"product_stock":40,"category":"MDVX","image":"http://dummyimage.com/226x100.png/5fa2dd/ffffff"},{"id":"2","name":"Biodex","selling_price":55.68,"total_purchase":90,"product_stock":43,"category":"ETH","image":"http://dummyimage.com/161x100.png/5fa2dd/ffffff"},{"id":"3","name":"Zathin","selling_price":84.42,"total_purchase":31,"product_stock":38,"category":"NCSM","image":"http://dummyimage.com/241x100.png/cc0000/ffffff"},{"id":"4","name":"Zoolab","selling_price":56.04,"total_purchase":21,"product_stock":93,"category":"CPAH","image":"http://dummyimage.com/214x100.png/5fa2dd/ffffff"},{"id":"5","name":"Hatity","selling_price":56.7,"total_purchase":27,"product_stock":7,"category":"AMX","image":"http://dummyimage.com/226x100.png/dddddd/000000"},{"id":"6","name":"Fix San","selling_price":57.72,"total_purchase":77,"product_stock":66,"category":"RXN^A","image":"http://dummyimage.com/106x100.png/ff4444/ffffff"},{"id":"7","name":"Keylex","selling_price":6.87,"total_purchase":56,"product_stock":46,"category":"INVH","image":"http://dummyimage.com/219x100.png/5fa2dd/ffffff"},{"id":"8","name":"Andalax","selling_price":43.37,"total_purchase":88,"product_stock":81,"category":"PAI","image":"http://dummyimage.com/205x100.png/dddddd/000000"},{"id":"9","name":"Domainer","selling_price":12.12,"total_purchase":36,"product_stock":45,"category":"GABC","image":"http://dummyimage.com/200x100.png/5fa2dd/ffffff"},{"id":"10","name":"Zoolab","selling_price":7.5,"total_purchase":19,"product_stock":47,"category":"TCRZ","image":"http://dummyimage.com/171x100.png/dddddd/000000"}]';


  //use case 
  // List<Products> somename = userListSeed(); -- then accessible na ang data from the name and shit
  List<Product> productListSeed(){
  var jsonObj = jsonDecode(ProductSeeder()._data) as List;
  List<Product> productList = jsonObj.map((data)=> Product.fromFireStore(data, data['id'])).toList();
  return productList;
  }
}
