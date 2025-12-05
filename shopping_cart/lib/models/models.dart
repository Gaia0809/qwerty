class Product {
  final String id;
  final String title;
  final double price;

  Product({
    required this.id, 
    required this.title, 
    required this.price
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product, 
    this.quantity = 1
  });
}