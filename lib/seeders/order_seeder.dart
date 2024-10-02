

import 'dart:convert';

import 'package:commerce_mobile/models/OrdersModel.dart';

class OrderSeeder{

  final String _data = '[{"id":"1","transaction_id":"1","product_id":"9","total_price":57.55,"quantity":68},{"id":"2","transaction_id":"1","product_id":"1","total_price":87.27,"quantity":76},{"id":"3","transaction_id":"1","product_id":"5","total_price":92.42,"quantity":67},{"id":"4","transaction_id":"2","product_id":"7","total_price":87.95,"quantity":13},{"id":"5","transaction_id":"3","product_id":"8","total_price":93.89,"quantity":82},{"id":"6","transaction_id":"1","product_id":"5","total_price":52.89,"quantity":73},{"id":"7","transaction_id":"1","product_id":"1","total_price":79.29,"quantity":95},{"id":"8","transaction_id":"1","product_id":"6","total_price":69.9,"quantity":8},{"id":"9","transaction_id":"5","product_id":"2","total_price":12.46,"quantity":43},{"id":"10","transaction_id":"3","product_id":"3","total_price":72.68,"quantity":61},{"id":"11","transaction_id":"2","product_id":"8","total_price":83.26,"quantity":33},{"id":"12","transaction_id":"1","product_id":"4","total_price":80.21,"quantity":79},{"id":"13","transaction_id":"2","product_id":"4","total_price":85.04,"quantity":21},{"id":"14","transaction_id":"4","product_id":"3","total_price":86.2,"quantity":72},{"id":"15","transaction_id":"3","product_id":"4","total_price":39.52,"quantity":14}]';


  //use case 
  // List<Products> somename = userListSeed(); -- then accessible na ang data from the name and shit
  List<Orders> orderListSeed(){
  var jsonObj = jsonDecode(OrderSeeder()._data) as List;
  List<Orders> orderList= jsonObj.map((data)=> Orders.fromFireStore(data, data['id'])).toList();
  return orderList;
  }
}