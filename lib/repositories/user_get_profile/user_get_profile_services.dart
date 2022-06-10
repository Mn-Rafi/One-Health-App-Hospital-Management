import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

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
}
