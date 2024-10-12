
class Transactions {
  final String id;
  final String user_name;
  final String customer_name;
  final double total_amount;
  final String date_time;

  Transactions(
      {required this.id,
      required this.customer_name,
      required this.total_amount,
      required this.date_time,
      required this.user_name});

  factory Transactions.fromFireStore(
      Map<String, dynamic> data, String transDoc) {
    return Transactions(
        id: transDoc,
        customer_name: data['customer_name'],
        total_amount: data['total_amount'],
        date_time: data['date_time'],
        user_name: data['user_name']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'customer_name': customer_name,
      'total_amount': total_amount,
      'date_time': date_time,
      'user_name': user_name
    };
  }


}
