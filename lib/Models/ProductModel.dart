import 'CategoryModel.dart';

class Product {
  int? id;
  String? title;
  num? price;
  String? description;
  Category? category;
  List<String>? images;
  int? categoryId;

  Product(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images,
        this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['images'] = this.images;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
