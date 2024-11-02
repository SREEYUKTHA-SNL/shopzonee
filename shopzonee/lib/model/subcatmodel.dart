class SubcategoryCategory {
  List<Data>? data;
  String? message;
  bool? success;

  SubcategoryCategory({this.data, this.message, this.success});

  SubcategoryCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? subcategoryname;
  String? subcategoryImage;
  int? categoryId;

  Data({this.id, this.subcategoryname, this.subcategoryImage, this.categoryId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryname = json['subcategoryname'];
    subcategoryImage = json['subcategory_image'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategoryname'] = this.subcategoryname;
    data['subcategory_image'] = this.subcategoryImage;
    data['category_id'] = this.categoryId;
    return data;
  }
}
