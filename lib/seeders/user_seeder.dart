
import 'dart:convert';

import 'package:commerce_mobile/models/UserModel.dart';

class UserSeeder {
  final String _data = '[{"id":"1","last_name":"Smiz","first_name":"Nadine","email":"nsmiz0@indiegogo.com","isVerified":false},{"id":"2","last_name":"Coggins","first_name":"Christoffer","email":"ccoggins1@nytimes.com","isVerified":true},{"id":"3","last_name":"Sorrie","first_name":"Rurik","email":"rsorrie2@patch.com","isVerified":true},{"id":"4","last_name":"Swadlinge","first_name":"Chevalier","email":"cswadlinge3@ovh.net","isVerified":true},{"id":"5","last_name":"Brierley","first_name":"Julietta","email":"jbrierley4@t-online.de","isVerified":true},{"id":"6","last_name":"Angel","first_name":"Clayson","email":"cangel5@clickbank.net","isVerified":true},{"id":"7","last_name":"Troyes","first_name":"Adah","email":"atroyes6@people.com.cn","isVerified":false},{"id":"8","last_name":"Currie","first_name":"Dorena","email":"dcurrie7@1und1.de","isVerified":true},{"id":"9","last_name":"Pleasaunce","first_name":"Faye","email":"fpleasaunce8@storify.com","isVerified":true},{"id":"10","last_name":"Leport","first_name":"Lars","email":"lleport9@360.cn","isVerified":false}]';


  //use case 
  // List<Users> somename = userListSeed(); -- then accessible na ang data from the name and shit
  List<Users> userListSeed(){
  var jsonObj = jsonDecode(UserSeeder()._data) as List;
  List<Users> userList = jsonObj.map((data)=> Users.fromFireStore(data, data['id'])).toList();
  return userList;
  }
}
