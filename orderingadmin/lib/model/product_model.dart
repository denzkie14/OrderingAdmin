class Product {
  int? id;
  int? categoryId;
  int? unitId;
  String? unit;
  String? category;
  String? code;
  String? title;
  String? description;
  List<String>? images;
  num? price;
  int? stock;
  DateTime? expirationDate;
  DateTime? dateAdded;
  int? addedBy;

  Product(
      {this.id,
      this.categoryId,
      this.unitId,
      this.unit,
      this.category,
      this.code,
      this.title,
      this.description,
      this.images,
      this.price,
      this.stock,
      this.expirationDate,
      this.dateAdded,
      this.addedBy});

  Product.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.categoryId = json['categoryId'];
    this.unitId = json['unitId'];
    this.unit = json['unit'];
    this.category = json['category'];
    this.code = json['code'];
    this.title = json['title'];
    this.description = json['description'];
    this.images = json['images'];
    this.price = json['price'];
    this.stock = json['stock'];
    this.expirationDate = json['expirationDate'];
    this.dateAdded = json['dateAdded'];
    this.addedBy = json['addedBy'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'unitId': unitId,
        'unit': unit,
        'category': category,
        'code': code,
        'title': title,
        'description': description,
        'images': images,
        'price': price,
        'stock': stock,
        'expirationDate': expirationDate,
        'dateAdded': dateAdded,
        'addedBy': addedBy
      };
}
