import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

part 'departmentsanddoctors_event.dart';
part 'departmentsanddoctors_state.dart';

class DepartmentsanddoctorsBloc
    extends Bloc<DepartmentsanddoctorsEvent, DepartmentsanddoctorsState> {
  final GetAllDoctorsServices _allDoctorsServices;
  DepartmentsanddoctorsBloc(this._allDoctorsServices)
      : super(DepartmentsanddoctorsInitial()) {
    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    final List<UserLocalData> userLocalDataList = userLocalData.values.toList();
    List<List<DoctorResponseModel>> doctorsList = [];
    on<DepartmentsanddoctorsEvent>((event, emit) {});
    on<DepartmentsanddoctorsInitialEvent>((event, emit) async {
      emit((DoctorsDetailsLoadingState()));
      try {
        final reponse = await _allDoctorsServices.getDoctorsFromListodId(
            token: userLocalDataList[0].token, doctorIds: event.doctorsIdList);
        doctorsList = reponse!;
        print('****************');
        log(reponse.toString());
        print('****************');
        emit((DoctorsDetailsLoadedState(doctorList: doctorsList)));
      } catch (e) {
        if (e is DioError) {
          showSnackBar(
            text: e.response!.data['message'],
            context: event.context,
            duration: 3000,
          );
        }
      }
    });
  }
}
