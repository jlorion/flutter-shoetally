

import 'dart:convert';

import 'package:commerce_mobile/models/TransactionsModel.dart';

class TransactionSeeder{
  final String _data = '[{"id":"1","customer_id":"2","status":"EU","total_amount":91.69,"date_time":"8/9/2024","user_id":"10"},{"id":"2","customer_id":"4","status":"AS","total_amount":18.18,"date_time":"12/10/2023","user_id":"5"},{"id":"3","customer_id":"3","status":"SA","total_amount":20.19,"date_time":"7/23/2024","user_id":"1"},{"id":"4","customer_id":"5","status":"AS","total_amount":85.38,"date_time":"3/9/2024","user_id":"7"},{"id":"5","customer_id":"5","status":"NA","total_amount":57.22,"date_time":"8/16/2024","user_id":"4"}]';


  //use case 
  // List<Users> somename = userListSeed(); -- then accessible na ang data from the name and shit
  List<Transactions> transListSeed(){
  var jsonObj = jsonDecode(TransactionSeeder()._data) as List;
  List<Transactions> list = jsonObj.map((data)=> Transactions.fromFireStore(data, data['id'])).toList();
  return list;
  }
}
