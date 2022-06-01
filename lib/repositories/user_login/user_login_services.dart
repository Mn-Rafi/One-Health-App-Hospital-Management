import 'dart:io';

import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_data_model.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_response_model.dart';

class UserLoginServices {
  Future<UserLoginResponseModel>? getUserResponseData(
      {required String email, required String password}) async {
    Dio dio = Dio();
    var response;
    UserLoginDataModel userDataModel =
        UserLoginDataModel(email: email, password: password);
    final data = userDataModel.toJson();
    try {
      response = await dio.post(ApiUtilities.baseUrl + ApiUtilities.loginPath,
          data: data);
    } on SocketException catch (_) {
      print('NO INTERNET CONNECTION');
    } catch (e) {
      print('SOME OTHER EXception');
    }
    final UserLoginResponseModel responseData =
        userLoginResponseModelFromJson(response.data);
    return responseData;
  }
}
