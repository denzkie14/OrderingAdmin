class Product {
  int? item_id;
  int? category_id;
  String? item_code;
  String? category_desc;
  String? title;
  String? item_desc;
  String? image;
  num? price;
  num? discount;
  String? unit;
  int? quantity;
  bool? isActive;
  bool? isDeleted;

  Product(
      {this.item_id,
      this.category_id,
      this.item_code,
      this.category_desc,
      this.title,
      this.item_desc,
      this.image,
      this.price,
      this.discount,
      this.unit,
      this.quantity,
      this.isActive,
      this.isDeleted});

  Product.fromJson(Map<String, dynamic> json) {
    this.item_id = json['item_id'];
    this.category_id = json['category_id'];
    this.unit = json['unit'];
    this.quantity = json['quantity'] ?? 0;
    this.item_code = json['item_code'];
    this.category_desc = json['category_desc'];
    this.title = json['title'];
    this.item_desc = json['item_desc'];
    this.image = json['image'];
    this.price = json['price'];
    this.discount = json['discount'];
    this.isActive = json['isActive'] ?? true;
    this.isDeleted = json['isDeleted'] ?? false;
  }

  Map<String, dynamic> toJson() => {
        'item_id': item_id,
        'category_id': category_id,
        'unit': unit,
        'quantity': quantity,
        'item_code': item_code,
        'category_desc': category_desc,
        'title': title,
        'item_desc': item_desc,
        'image': image,
        'price': price,
        'discount': discount,
        'isActive': isActive,
        'isDeleted': isDeleted
      };
}
