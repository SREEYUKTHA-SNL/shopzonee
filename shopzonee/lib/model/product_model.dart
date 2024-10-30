

class ProductModel {
  int? id;
  String? productname;
  String? price;
  String? description;
  String? size;
  String? color;
  String? image;
  int? category;
  int? subcategory;

  ProductModel(
      {this.id,
      this.productname,
      this.price,
      this.description,
      this.size,
      this.color,
      this.image,
      this.category,
      this.subcategory});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['productname'];
    price = json['price'];
    description = json['description'];
    size = json['size'];
    color = json['color'];
    image = json['image'];
    category = json['category'];
    subcategory = json['subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productname'] = this.productname;
    data['price'] = this.price;
    data['description'] = this.description;
    data['size'] = this.size;
    data['color'] = this.color;
    data['image'] = this.image;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    return data;
  }
}