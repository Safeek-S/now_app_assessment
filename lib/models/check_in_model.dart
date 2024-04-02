class CheckIn {
  final String id;
  final String retailerId;
  final String userId;
  final DateTime checkInTime;
  final double? latitude;
  final double? longitude;
  final DateTime? updatedAt;

  CheckIn({
    required this.id,
    required this.retailerId,
    required this.userId,
    required this.checkInTime,
    this.latitude,
    this.longitude,
    this.updatedAt,
  });

  // Method to create a CheckIn object from a map
  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      id: json['id'],
      retailerId: json['retailer_id'],
      userId: json['user_id'],
      checkInTime: DateTime.parse(json['check_in_time']),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  // Method to convert a CheckIn object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'retailer_id': retailerId,
      'user_id': userId,
      'check_in_time': checkInTime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
