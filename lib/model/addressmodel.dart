class Address {
  final int?id;
  final int ?userid;
  final String name;
  final dynamic phonenumber;
  final dynamic houseNo;
  final String street;
  final String city;
  final String district;
  final String state;
  final dynamic pincode;

  Address({
    this.id,
     this.userid,
    required this.name,
    required this.phonenumber,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.district,
    required this.state,
    required this.pincode,
  });


  factory Address.fromJson(Map<String, dynamic> json) {
    print('ggggggg');
    return Address(
      id:json['id'],
      userid: json['userid'],
      name: json['name'],
      phonenumber: json['phonenumber'],
      houseNo: json['house_no'],
      street: json['street'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      pincode: json['pincode'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
       'userid': userid.toString(),
      'name': name,
      'phonenumber': phonenumber,
      'house_no': houseNo,
      'street': street,
      'city': city,
      'district': district,
      'state': state,
      'pincode': pincode,
    };
  }
}
