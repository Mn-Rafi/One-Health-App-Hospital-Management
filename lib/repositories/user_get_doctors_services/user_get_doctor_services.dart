import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
import 'package:one_health_hospital_app/logic/models/doctors_respoonse_model_for_search.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/themedata.dart';

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

  static Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
  static List<UserLocalData> userLocalDataList = userLocalData.values.toList();

  Future<DoctorResponseModelForSearch?> getAllDoctorsForSearch() async {
    log('sakfhksdfhkjdsh');
    DoctorResponseModelForSearch doctorResponseModel;
    Dio dio = Dio();
    dio.options.headers["auth-token"] = userLocalDataList[0].token;
    Response response = await dio.get(
      ApiUtilities.getAllDoctors,
    );
    log(response.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // log(response.toString());
      doctorResponseModel = (response.data)
          .map((i) => DoctorResponseModelForSearch.fromJson(i.doctor))
          .toList();
      // log(doctorResponseModel.toString());
      print('success');
      return doctorResponseModel;
    }
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
