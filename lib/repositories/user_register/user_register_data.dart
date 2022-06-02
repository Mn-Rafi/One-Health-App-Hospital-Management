import 'dart:convert';
import 'dart:io';

UserRegisterInputModel userRegisterInputModelFromJson(json) =>
    UserRegisterInputModel.fromJson(json);

String userRegisterInputModelToJson(UserRegisterInputModel data) =>
    json.encode(data.toJson());

class UserRegisterInputModel {
  UserRegisterInputModel({
    required this.firstName,
    required this.secondName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.blood,
    required this.password,
    required this.image,
  });

  String firstName;
  String secondName;
  int age;
  String gender;
  String email;
  String phone;
  String blood;
  String password;
  File image;

  factory UserRegisterInputModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterInputModel(
        firstName: json["firstName"],
        secondName: json["secondName"],
        age: json["age"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        blood: json["blood"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "secondName": secondName,
        "age": age,
        "gender": gender,
        "email": email,
        "phone": phone,
        "blood": blood,
        "password": password,
        "image": image,
      };
}
