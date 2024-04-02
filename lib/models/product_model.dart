class Product {
  String? prodImage;
  int? prodId;
  String? prodCode;
  String? prodName;
  String? uom;
  int? catId;
  bool? underWarranty;
  double? prodRkPrice;

  Product({
    this.prodImage,
    this.prodId,
    this.prodCode,
    this.prodName,
    this.uom,
    this.catId,
    this.underWarranty,
    this.prodRkPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        prodImage: json['prodImage']["small"],
        prodId: int.parse(json['prodId']),
        prodCode: json['prodCode'],
        prodName: json['prodName'],
        uom: json['uom'],
        catId: int.parse(json['catId']),
        underWarranty: json['underWarranty'],
        prodRkPrice: double.parse(json['prodRkPrice']),
      );


      factory Product.fromDb(Map<String, dynamic> json) => Product(
        prodImage: json['prodImage'],
        prodId: json['id'],
        prodCode: json['prodCode'],
        prodName: json['prodName'],
        uom: json['uom'],
        catId: json['catId'],
        underWarranty: json['underWarranty'],
        prodRkPrice: double.parse(json['prodRkPrice']),
      );

  Map<String, dynamic> toJson() => {
        'prodImage': prodImage,
        'prodId': prodId,
        'prodCode': prodCode,
        'prodName': prodName,
        'uom': uom,
        'catId': catId,
        'underWarranty': underWarranty,
        'prodRkPrice': prodRkPrice,
      };

      Map<String, dynamic> toDb() => {
        'prodImage': prodImage,
        'id': prodId,
        'prodCode': prodCode,
        'prodName': prodName,
        'uom': uom,
        'catId': catId,
        'underWarranty': underWarranty,
        'prodRkPrice': prodRkPrice,
      };

}
