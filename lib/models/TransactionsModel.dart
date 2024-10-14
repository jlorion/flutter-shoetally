class Transactions {
  final String id;
  final String user_name;
  final String customer_name;
  final double total_amount;
  final double total_profit;
  final String date_time;

  Transactions({
    required this.id,
    required this.customer_name,
    required this.total_amount,
    required this.total_profit,
    required this.date_time,
    required this.user_name,
  });

  factory Transactions.fromFireStore(
      Map<String, dynamic> data, String transDoc) {
    return Transactions(
      id: transDoc,
      customer_name: data["customer_name"] ?? 'customernam testing',
      total_amount: (data['total_amount'] as num?)?.toDouble() ??
          0.0, // Convert and provide default
      total_profit: (data['total_profit'] as num?)?.toDouble() ??
          0.0, // Convert and provide default
      date_time: data['date_time'] ??
          '', // Provide a default value for date_time if needed
      user_name: data['user_name'] ?? 'username testing',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customer_name,
      'total_amount': total_amount,
      'total_profit': total_profit, // Include total_profit in JSON
      'date_time': date_time,
      'user_name': user_name,
    };
  }
}
