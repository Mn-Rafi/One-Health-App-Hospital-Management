import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class GetAllDoctorsServices {
  Future<Response> getAllDoctors(
      {required String token,}) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      ApiUtilities.getAllDoctors,
    );
    return response;
  }
}

class GetAllDepartments{
  Future<Response> getAllDepartments(
      {required String token,}) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      ApiUtilities.getAllDepartments,
    );
    return response;
  }
}