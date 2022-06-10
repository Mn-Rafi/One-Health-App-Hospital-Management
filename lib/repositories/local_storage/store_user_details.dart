import 'package:hive/hive.dart';

part 'store_user_details.g.dart';

@HiveType(typeId: 0)
class UserLocalData extends HiveObject {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String secondName;
  @HiveField(4)
  final int age;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final String email;
  @HiveField(7)
  final String phone;
  @HiveField(8)
  final String blood;
  @HiveField(9)
  final String password;
  @HiveField(10)
  final String image;

  UserLocalData({
    required this.token,
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
}
