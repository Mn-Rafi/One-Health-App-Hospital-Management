import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class UserAppointmentServices {
  Future<Response> getAppoiByDtae(
      {required String token,
      required String doctorId,
      required DateTime dateTime}) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      '${ApiUtilities.baseUrl}appointment/$doctorId/$dateTime',
    );
    return response;
  }
}
