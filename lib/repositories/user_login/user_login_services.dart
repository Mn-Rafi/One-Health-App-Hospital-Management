import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_data_model.dart';

class UserLoginServices {
  Future<Response> getUserResponseData(
      {required String email, required String password}) async {
    Dio dio = Dio();
    UserLoginDataModel userDataModel =
        UserLoginDataModel(email: email, password: password);
    final data = userDataModel.toJson();
    Response response = await dio
        .post(ApiUtilities.baseUrl + ApiUtilities.loginPath, data: data);

    return response;
  }

  Future requestOtp({required String number}) async {
    Dio dio = Dio();
    Response response = await dio.post(
        ApiUtilities.baseUrl + ApiUtilities.requestOtpPath,
        data: {"phone": "+91$number"});
    return response;
  }

  Future<Response> verifyOtp(
      {required String mobileNumber, required int otp}) async {
    Dio dio = Dio();
    final data = {"phone": '+91$mobileNumber', "otpVerify": otp};
    Response response = await dio
        .post(ApiUtilities.baseUrl + ApiUtilities.verifyOtpPath, data: data);
    return response;
  }
}

