class OrderItem {
  String? id;
  String? orderId;
  int? productId;
  int? quantity;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'],
        orderId: json['order_id'],
        productId: json['product_id'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'quantity': quantity,
      };
}
