import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String last_name;
  final String email;
  final String first_name;
  bool isVerified;

  Users(
      {required this.id,
      required this.last_name,
      required this.email,
      required this.first_name,
      required this.isVerified});

  factory Users.fromFireStore(Map<String, dynamic> data, String usersDoc) {
    return Users(
        id: usersDoc,
        last_name: data["last_name"],
        email: data["email"],
        first_name: data["first_name"],
        isVerified: data["isVerified"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_name': last_name,
      'first_name': first_name,
      'email': email,
      'isVerified': isVerified
    };
  }
}

class Customers {
  final String id;
  final String name;
  final String phone_number;
  final String address;

  Customers(
      {required this.id,
      required this.name,
      required this.phone_number,
      required this.address});
}

class Product {
  final String id;
  final String name;
  final int selling_price_per_unit;
  final double total_selling_price;
  final int profit_per_unit;
  final int product_stock;
  final String gender;
  final String category;
}

class Transactions {
  final String id;
  final String customer_id;
  final String status;
  final double total_amount;
  final Timestamp date_time;

  Transactions(
      {required this.id,
      required this.customer_id,
      required this.status,
      required this.total_amount,
      this.date_time});
}

class Orders {
  final String transaction_id;
  final String product_id;
  final int quantity;
}
