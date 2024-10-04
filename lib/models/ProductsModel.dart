class Product {
  final String id;
  final String name;
  final double selling_price;
  final double total_purchase;
  final int product_stock;
  final String category;
  final String image;

  Product(
      {required this.id,
      required this.name,
      required this.selling_price,
      required this.total_purchase,
      required this.product_stock,
      required this.category, 
      required this.image});

  factory Product.fromFireStore(Map<String, dynamic> data, String userDoc) {
    return Product(
        id: userDoc,
        name: data['name'],
        selling_price: data['selling_price'],
        total_purchase: data['total_purchase'],
        product_stock: data['product_stock'],
        category: data['category'],
        image: data['image']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'selling_price': selling_price,
      'total_purchase': total_purchase,
      'product_stock': product_stock,
      'category': category,
      'image': image
    };
  }
}
