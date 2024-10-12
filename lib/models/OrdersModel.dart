
class Orders {
  final String id;
  final String product_name;
  final String productImage;
  final double total_price;
  final int quantity;

  Orders(
      {required this.id,
      required this.product_name,
      required this.productImage,
      required this.total_price,
      required this.quantity});

  factory Orders.fromFireStore(Map<String, dynamic> data, String orderDoc) {
    return Orders(
      id: orderDoc,
      product_name: data['product_id'],
      productImage: data['productImage'],
      total_price: data['total_price'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'product_id': product_name,
      'productImage': productImage,
      'total_price': total_price,
      'quantity': quantity
    };


  }
}
