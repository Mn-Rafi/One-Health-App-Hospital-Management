import 'dart:convert';

UserLoginDataModel userLoginDataModelFromJson(String str) =>
    UserLoginDataModel.fromJson(json.decode(str));

String userLoginDataModelToJson(UserLoginDataModel data) =>
    json.encode(data.toJson());

class UserLoginDataModel {
  UserLoginDataModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory UserLoginDataModel.fromJson(Map<String, dynamic> json) =>
      UserLoginDataModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
