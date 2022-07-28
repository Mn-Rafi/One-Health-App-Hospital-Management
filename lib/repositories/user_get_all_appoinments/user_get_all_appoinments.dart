// import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';
// import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class AppointmentsServices {
  Future<Response> getAppointments(
      {required String token, required String id}) async {
    log(id);
    Dio dio = Dio();
    log(token);

    dio.options.headers["auth-token"] = token;

    final response = await dio.get(
      '${ApiUtilities.baseUrl}/appointment/$id',
    );
    log(response.toString());

    return response;
  }
}
