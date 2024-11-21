class UserModel {
  Data? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? password;
  String? number;
  String? role;
  int? loginId;

  Data(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.number,
      this.role,
      this.loginId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    role = json['role'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['number'] = this.number;
    data['role'] = this.role;
    data['login_id'] = this.loginId;
    return data;
  }
}
