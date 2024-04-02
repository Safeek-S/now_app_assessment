

class Order {
  String? id;
  String? retailerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Order({
    this.id,
    this.retailerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        retailerId: json['retailer_id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'retailer_id': retailerId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}