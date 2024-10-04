import 'dart:convert';

import 'package:commerce_mobile/models/CustomersModel.dart';

class CustomerSeeder {
  final String _data =
      '[{"id":"1","name":"Jasiak","phone_number":"309-966-9602","address":"330 Westridge Way"},{"id":"2","name":"Kynvin","phone_number":"757-856-7384","address":"6 Crownhardt Street"},{"id":"3","name":"Rusted","phone_number":"598-777-8519","address":"7400 Shelley Center"},{"id":"4","name":"Floris","phone_number":"315-205-6681","address":"8 Southridge Alley"},{"id":"5","name":"Maxwaile","phone_number":"724-462-4113","address":"955 Westend Crossing"}]';

  //use case
  // List<Users> somename = userListSeed(); -- then accessible na ang data from the name and shit
  // List<Customers> customerSeed() {
  //   var jsonObj = jsonDecode(CustomerSeeder()._data) as List;
  //   List<Customers> list = jsonObj
  //       .map((data) => Customers.fromFireStore(data, data['id']))
  //       .toList();
  //   return list;
  // }
}
