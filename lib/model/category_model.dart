class CategoryModel {
  int? id;
  String? categoryname;

  CategoryModel({this.id, this.categoryname});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryname = json['categoryname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryname'] = this.categoryname;
    return data;
  }
}