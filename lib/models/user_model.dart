

class User {
  String? id;
  String? name;
  String? email;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? password;

  User({
    this.id,
     this.name,
     this.email,
     this.latitude,
     this.longitude,
     this.createdAt,
    this.updatedAt,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        password: json['password'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'latitude': latitude,
        'password': password,
        'longitude': longitude,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
