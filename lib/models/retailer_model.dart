class Retailer {
  String? id;
  String name;
  String address;
  String? phoneNumber;
  String? email;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? password;
  String? companyName;
  Retailer({
    this.id,
    required this.name,
    required this.address,
    this.phoneNumber,
    this.email,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.companyName
  });

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        password: json['password'],
        companyName: json['company_name'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phone_number': phoneNumber,
        'email': email,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'password': password,
        'company_name': companyName
      };
}
