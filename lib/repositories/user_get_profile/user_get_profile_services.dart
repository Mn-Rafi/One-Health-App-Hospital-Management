import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class GetUserProfileServices {
  // Future<Response> getUserResponseData(
  //     {required String email, required String password}) async {
  //   Dio dio = Dio();
  //   UserLoginDataModel userDataModel =
  //       UserLoginDataModel(email: email, password: password);
  //   final data = userDataModel.toJson();
  //   Response response = await dio
  //       .post(ApiUtilities.baseUrl + ApiUtilities.loginPath, data: data);

  //   return response;
  // }

  Future<Response> getUserProfileDetails(
      {required String token, required String id}) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      ApiUtilities.getProfile + id,
    );
    return response;
  }
}
