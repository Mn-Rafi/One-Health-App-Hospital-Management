import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class GetAllDoctorsServices {
  Future<Response> getAllDoctors({
    required String token,
  }) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      ApiUtilities.getAllDoctors,
    );
    return response;
  }

  Future<List<List<DoctorResponseModel>>?> getDoctorsFromListodId(
      {required String token, required List<List<String>> doctorIds}) async {
    List<List<DoctorResponseModel>> listofListOfDoctors = [];
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    for (int i = 0; i < doctorIds.length; i++) {
      List<DoctorResponseModel> listOfDoctors = [];
      for (int j = 0; j < doctorIds[i].length; j++) {
        log('alomost there 1');
        Response response = await dio.get(
          '${ApiUtilities.getAllDoctors}/${doctorIds[i][j]}',
        );
        log('alomost there 2');
        if (response.statusCode == 200 || response.statusCode == 201) {
          log('_______________________________');
          log(response.data.toString());
          listOfDoctors.add(DoctorResponseModel.fromJson(response.data));
          log('____________________________');
          log(listOfDoctors.toString());
          log('____________________________');
        }
      }
      listofListOfDoctors.add(listOfDoctors);
    }
    return listofListOfDoctors;
  }
}

class GetAllDepartments {
  Future<Response> getAllDepartments({
    required String token,
  }) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      ApiUtilities.getAllDepartments,
    );
    return response;
  }
}
