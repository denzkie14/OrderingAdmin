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
      this.isActive,
      this.isDeleted});

  Product.fromJson(Map<String, dynamic> json) {
    this.item_id = json['item_id'];
    this.category_id = json['category_id'];
    this.unit = json['unit'];
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
