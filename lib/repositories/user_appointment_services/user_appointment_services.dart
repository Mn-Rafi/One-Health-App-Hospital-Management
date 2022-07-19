import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class UserAppointmentServices {
  Future<Response> getAppointmentByDtae(
      {required String token,
      required String doctorId,
      required DateTime dateTime}) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      '${ApiUtilities.baseUrl}/appointment/$doctorId/$dateTime',
    );
    return response;
  }

  Future cancelAppointment(
      {required String id,
      required String token,
      required String reason}) async {
    Dio dio = Dio();
    Response response = await dio.put('${ApiUtilities.baseUrl}/appointment/$id',
        data: {"status": "Cancelled", "cancelReason": reason},
        options: Options(
          headers: {
            "auth-token": token,
          },
        ));
    return response;
  }
}
