class Category {
  int? category_id;
  String? category_desc;
  bool? isDeleted;

  Category({this.category_id, this.category_desc, this.isDeleted});

  Category.fromJson(Map<String, dynamic> json) {
    category_id = json['category_id'];
    category_desc = json['category_desc'];
    isDeleted = json['isDeleted'] ?? false;
  }

  Map<String, dynamic> toJson() => {
        'category_id': category_id,
        'category_desc': category_desc,
        'isDeleted': isDeleted,
      };
}
