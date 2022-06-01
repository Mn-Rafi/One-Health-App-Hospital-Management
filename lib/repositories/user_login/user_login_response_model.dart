import 'dart:convert';

UserLoginResponseModel userLoginResponseModelFromJson(json) {
  return UserLoginResponseModel.fromJson(json);
}

String userLoginResponseModelToJson(UserLoginResponseModel data) =>
    json.encode(data.toJson());

class UserLoginResponseModel {
  UserLoginResponseModel({
    required this.user,
    required this.token,
    required this.message,
  });

  User user;
  String token;
  String message;

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "message": message,
      };
}

class User {
  User({
    required this.id,
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

  String id;
  String firstName;
  String secondName;
  int age;
  String gender;
  String email;
  String phone;
  String blood;
  String password;
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
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
        "_id": id,
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
