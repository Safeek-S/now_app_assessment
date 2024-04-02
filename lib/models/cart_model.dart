class Cart {
  String? id;
  int? productId;
  int? quantity;

  Cart({this.id, this.productId, this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}