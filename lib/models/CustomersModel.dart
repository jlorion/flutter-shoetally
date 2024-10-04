class Customers {
  String id;
  final String name;
  final String phone_number;
  final String address;

  Customers(
      {required this.id,
      required this.name,
      required this.phone_number,
      required this.address});

  factory Customers.fromFireStore(
      Map<String, dynamic> data, String customerDoc) {
    return Customers(
        id: customerDoc,
        name: data['name'],
        phone_number: data['phone_number'],
        address: data['address']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phone_number,
      'address': address
    };
  }
}
