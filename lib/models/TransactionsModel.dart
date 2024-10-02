
class Transactions {
  final String id;
  final String user_id;
  final String customer_id;
  final String status;
  final double total_amount;
  final String date_time;

  Transactions(
      {required this.id,
      required this.customer_id,
      required this.status,
      required this.total_amount,
      required this.date_time,
      required this.user_id});

  factory Transactions.fromFireStore(
      Map<String, dynamic> data, String transDoc) {
    return Transactions(
        id: transDoc,
        customer_id: data['customer_id'],
        status: data['status'],
        total_amount: data['total_amount'],
        date_time: data['date_time'],
        user_id: data['user_id']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'customer_id': customer_id,
      'status': status,
      'total_amount': total_amount,
      'date_time': date_time,
      'user_id': user_id
    };
  }


}
