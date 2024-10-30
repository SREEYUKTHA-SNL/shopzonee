class WishlistModel {
  int? id;
  String? productid;
  String? productname;
  String? userid;
  String? wishlistStatus;
  String? price;
  String? image;

  WishlistModel(
      {this.id,
      this.productid,
      this.productname,
      this.userid,
      this.wishlistStatus,
      this.price,
      this.image});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productid = json['productid'];
    productname = json['productname'];
    userid = json['userid'];
    wishlistStatus = json['wishlist_status'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productid'] = this.productid;
    data['productname'] = this.productname;
    data['userid'] = this.userid;
    data['wishlist_status'] = this.wishlistStatus;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}