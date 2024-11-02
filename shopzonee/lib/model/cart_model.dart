class CartModel {
  Data? data;
  String? message;
  int? success;

  CartModel({this.data, this.message, this.success});

  CartModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? productid;
  String? productname;
  String? userid;
  String? quantity;
  int? cartStatus;
  String? description;
  String? price;
  String? image;

  Data(
      {this.id,
      this.productid,
      this.productname,
      this.userid,
      this.quantity,
      this.cartStatus,
      this.description,
      this.price,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productid = json['productid'];
    productname = json['productname'];
    userid = json['userid'];
    quantity = json['quantity'];
    cartStatus = json['cart_status'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productid'] = this.productid;
    data['productname'] = this.productname;
    data['userid'] = this.userid;
    data['quantity'] = this.quantity;
    data['cart_status'] = this.cartStatus;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
