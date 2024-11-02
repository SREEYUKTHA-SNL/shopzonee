class UserModel {
  int? loginId;
  int? userId;
  String? email;
  String? password;
  String? name;
  String? role;
  String? number;

  UserModel(
      {this.loginId,
      this.userId,
      this.email,
      this.password,
      this.name,
      this.role,
      this.number});

  UserModel.fromJson(Map<String, dynamic> json) {
    loginId = json['login_id'];
    userId = json['user_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_id'] = this.loginId;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['role'] = this.role;
    data['number'] = this.number;
    return data;
  }
}