import 'package:dio/dio.dart';

import 'package:one_health_hospital_app/repositories/api_utilities.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GetUserProfileServices {
  Future<Response> getUserProfileDetails(
      {required String token, required String id}) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      ApiUtilities.baseUrl + ApiUtilities.getUserProfilePath + id,
    );
    return response;
  }

  Future<Response> changeUserPassword(
      {required String token,
      required String id,
      required String oldPassword,
      required String newPassword}) async {
    var formData = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "cPassword": newPassword
    };
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.put(
      '${ApiUtilities.baseUrl}/user/changepassword/$id',
      data: formData,
    );
    return response;
  }

  Future<Response> editProfile(
      {required EditProfileModel editProfileModel,
      required bool isImageChaned,
      required String id,
      required String token}) async {
    Dio dio = Dio();
    File? imageFile = !isImageChaned
        ? await _fileFromImageUrl(editProfileModel.imagePath)
        : null;
    FormData formData = FormData.fromMap({
      "firstName": editProfileModel.firstName,
      "secondName": editProfileModel.secondName,
      "age": editProfileModel.age,
      "gender": editProfileModel.gender,
      "blood": editProfileModel.blood,
      "phone": editProfileModel.phone,
      "email": editProfileModel.email,
      "image": await MultipartFile.fromFile(
          !isImageChaned ? imageFile!.path : editProfileModel.imagePath,
          filename: "image.jpg"),
    });
    dio.options.headers["auth-token"] = token;
    Response response = await dio.put(
      "${ApiUtilities.baseUrl}/user/$id",
      data: formData,
    );
    return response;
  }
}

class EditProfileModel {
  final String firstName;
  final String secondName;
  final int age;
  final String gender;
  final String blood;
  final String phone;
  final String imagePath;
  final String email;
  EditProfileModel({
    required this.firstName,
    required this.secondName,
    required this.age,
    required this.gender,
    required this.blood,
    required this.imagePath,
    required this.phone,
    required this.email,
  });
}

Future<File> _fileFromImageUrl(String path) async {
  final response = await http.get(Uri.parse(path));

  final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, 'imagetest.png'));

  file.writeAsBytesSync(response.bodyBytes);

  return file;
}
