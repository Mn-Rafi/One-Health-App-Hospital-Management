class GetPrfoleResponseModel {
  User? user;
  String? message;

  GetPrfoleResponseModel({this.user, this.message});

  GetPrfoleResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? secondName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? blood;
  String? password;
  String? image;
  bool? access;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.firstName,
      this.secondName,
      this.age,
      this.gender,
      this.email,
      this.phone,
      this.blood,
      this.password,
      this.image,
      this.access,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    secondName = json['secondName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    blood = json['blood'];
    password = json['password'];
    image = json['image'];
    access = json['access'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['secondName'] = this.secondName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['blood'] = this.blood;
    data['password'] = this.password;
    data['image'] = this.image;
    data['access'] = this.access;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
