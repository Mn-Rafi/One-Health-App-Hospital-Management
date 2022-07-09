// import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class AppointmentsServices {
  Future<Response> getAppointments(
      {required String token, required String id}) async {
    log(id);
    Dio dio = Dio();
    log(token);

    dio.options.headers["auth-token"] = token;
    // Response response = await dio.get(
    //   'https://onehealthhospital.site/api/appointment/$id',
    // );
    final response = await dio.get(
      'https://onehealthhospital.site/api/appointment/$id',
    );
    log(response.toString());

    return response;
  }
}
