// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:one_health_hospital_app/logic/models/all_appointments_response_model.dart';

// import 'package:one_health_hospital_app/logic/models/all_departments_response_model.dart';
// import 'package:one_health_hospital_app/logic/models/all_doctor_response_model.dart';
// import 'package:one_health_hospital_app/logic/models/prescriptions_response_model.dart';
// import 'package:one_health_hospital_app/logic/models/user_profile_model.dart';
// import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
// import 'package:one_health_hospital_app/repositories/user_get_all_appoinments/user_get_all_appoinments.dart';
// import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';
// import 'package:one_health_hospital_app/repositories/user_get_profile/user_get_profile_services.dart';
// import 'package:one_health_hospital_app/repositories/user_prescription_services/user_prescription_services.dart';
// import 'package:one_health_hospital_app/themedata.dart';

// part 'homepage_event.dart';
// part 'homepage_state.dart';

// class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
//   final GetAllDoctorsServices _allDoctorsServices;
//   final GetAllDepartments _allDepartmentsServices;
//   final AppointmentsServices _appointmentsServices;
//   final UserPrescriptionServices _userPrescriptionServices;
//   final GetUserProfileServices _getUserProfileServices;
//   final BuildContext context;
//   HomepageBloc(
//     this._allDoctorsServices,
//     this._allDepartmentsServices,
//     this._appointmentsServices,
//     this._userPrescriptionServices,
//     this._getUserProfileServices,
//     this.context,
//   ) : super(HomepageInitial()) {
//     List<Doctor>? doctorsList = [];
//     List<Department>? departmentsList = [];
//     List<Appointment>? appointmentsList = [];
//     List<Prescription>? prescriptionsList = [];
//     GetPrfoleResponseModel? profileresponse;
//     final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
//     final List<UserLocalData> userLocalDataList = userLocalData.values.toList();
//     log(userLocalDataList[0].token);
//     on<HomepageEvent>((event, emit) async {
//       try {
//         final Response responseForm =
//             await _getUserProfileServices.getUserProfileDetails(
//           token: userLocalDataList[0].token,
//           id: userLocalDataList[0].id,
//         );
//         if (responseForm.statusCode == 200) {
//           profileresponse = GetPrfoleResponseModel.fromJson(responseForm.data);
//           log(responseForm.toString());
//         } else {
//           throw DioError;
//         }
//       } catch (e) {}
//       emit(HomepageInitialState(
//         userImage: profileresponse!.user!.image ?? userLocalDataList[0].image,
//         userName:
//             profileresponse!.user!.firstName ?? userLocalDataList[0].firstName,
//       ));

//       try {
//         log(userLocalDataList[0].id);
//         final response = await _allDoctorsServices.getAllDoctors(
//             token: userLocalDataList[0].token);
//         final responseData = AllDoctorsResponseModel.fromJson(response.data);
//         doctorsList = responseData.doctor;
//         try {
//           final response = await _allDepartmentsServices.getAllDepartments(
//               token: userLocalDataList[0].token);
//           final responseData =
//               AllDepartmentsResponseModel.fromJson(response.data);
//           departmentsList = responseData.department;
//         } catch (e) {
//           if (e is DioError) {
//             showSnackBar(
//               text: e.response!.data['message'],
//               context: context,
//               duration: 3000,
//             );
//           }
//         }

//         try {
//           final response = await _appointmentsServices.getAppointments(
//               token: userLocalDataList[0].token, id: userLocalDataList[0].id);
//           final responseData =
//               UserAppointmentsResponseModel.fromJson(response.data);
//           // log(responseData.toString());
//           if (response.statusCode == 200 || response.statusCode == 201) {
//             appointmentsList = responseData.appointment;
//             appointmentsList!.sort((a, b) => a.date!.compareTo(b.date!));

//             log('success');
//           }
//         } catch (e) {
//           if (e is DioError) {
//             showSnackBar(
//               text: e.response!.data['message'],
//               context: context,
//               duration: 3000,
//             );
//           }
//         }
//         emit(HomePageFetchDoctorsSuccessState(
//           prescriptionList: prescriptionsList,
//           appointmentList: appointmentsList,
//           departmentList: departmentsList,
//           doctorList: doctorsList,
//           userImage: profileresponse!.user!.image ?? userLocalDataList[0].image,
//           userName: profileresponse!.user!.firstName ??
//               userLocalDataList[0].firstName,
//         ));

//         try {
//           final response = await _userPrescriptionServices.getAllPrescriptions(
//               token: userLocalDataList[0].token,
//               userId: userLocalDataList[0].id);
//           if (response.statusCode == 200 || response.statusCode == 201) {
//             log(response.toString());
//             final responseData =
//                 UserPrescriptonsResponseModel.fromJson(response.data);
//             prescriptionsList = responseData.prescription;
//             log(responseData.prescription.toString());
//             emit(HomePageFetchDoctorsSuccessState(
//               prescriptionList: prescriptionsList,
//               appointmentList: appointmentsList,
//               departmentList: departmentsList,
//               doctorList: doctorsList,
//               userImage:
//                   profileresponse!.user!.image ?? userLocalDataList[0].image,
//               userName: profileresponse!.user!.firstName ??
//                   userLocalDataList[0].firstName,
//             ));
//           }
//         } catch (e) {
//           if (e is DioError) {
//             showSnackBar(
//               text: e.response!.data['message'],
//               context: context,
//               duration: 3000,
//             );
//           }
//         }
//       } catch (e) {
//         if (e is DioError) {
//           showSnackBar(
//             text: e.response!.data['message'],
//             context: context,
//             duration: 3000,
//           );
//         }
//       }
//     });

//     add(HomepageEvent());
//     on<HomePageNavigateToDepartments>((event, emit) {
//       emit(HomePageNavigateToDepartmentsState(
//           department: event.department, currentIndex: event.currentIndex));
//     });
//   }
// }



import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:one_health_hospital_app/logic/models/all_appointments_response_model.dart';

import 'package:one_health_hospital_app/logic/models/all_departments_response_model.dart';
import 'package:one_health_hospital_app/logic/models/all_doctor_response_model.dart';
import 'package:one_health_hospital_app/logic/models/prescriptions_response_model.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_get_all_appoinments/user_get_all_appoinments.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';
import 'package:one_health_hospital_app/repositories/user_prescription_services/user_prescription_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final GetAllDoctorsServices _allDoctorsServices;
  final GetAllDepartments _allDepartmentsServices;
  final AppointmentsServices _appointmentsServices;
  final UserPrescriptionServices _userPrescriptionServices;
  final BuildContext context;
  HomepageBloc(
    this._allDoctorsServices,
    this._allDepartmentsServices,
    this._appointmentsServices,
    this._userPrescriptionServices,
    this.context,
  ) : super(HomepageInitial()) {
    List<Doctor>? doctorsList = [];
    List<Department>? departmentsList = [];
    List<Appointment>? appointmentsList = [];
    List<Prescription>? prescriptionsList = [];
    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    final List<UserLocalData> userLocalDataList = userLocalData.values.toList();
    log(userLocalDataList[0].token);
    on<HomepageEvent>((event, emit) async {
      emit(HomepageInitialState(
        userImage: userLocalDataList[0].image,
        userName: userLocalDataList[0].firstName,
      ));
      try {
        log(userLocalDataList[0].id);
        final response = await _allDoctorsServices.getAllDoctors(
            token: userLocalDataList[0].token);
        final responseData = AllDoctorsResponseModel.fromJson(response.data);
        doctorsList = responseData.doctor;
        try {
          final response = await _allDepartmentsServices.getAllDepartments(
              token: userLocalDataList[0].token);
          final responseData =
              AllDepartmentsResponseModel.fromJson(response.data);
          departmentsList = responseData.department;
        } catch (e) {
          if (e is DioError) {
            showSnackBar(
              text: e.response!.data['message'],
              context: context,
              duration: 3000,
            );
          }
        }

        try {
          final response = await _appointmentsServices.getAppointments(
              token: userLocalDataList[0].token, id: userLocalDataList[0].id);
          final responseData =
              UserAppointmentsResponseModel.fromJson(response.data);
          // log(responseData.toString());
          if (response.statusCode == 200 || response.statusCode == 201) {
            appointmentsList = responseData.appointment;
            appointmentsList!.sort((a, b) => a.date!.compareTo(b.date!));

            log('success');
          }
        } catch (e) {
          if (e is DioError) {
            showSnackBar(
              text: e.response!.data['message'],
              context: context,
              duration: 3000,
            );
          }
        }
        emit(HomePageFetchDoctorsSuccessState(
          prescriptionList: prescriptionsList,
          appointmentList: appointmentsList,
          departmentList: departmentsList,
          doctorList: doctorsList,
          userImage: userLocalDataList[0].image,
          userName: userLocalDataList[0].firstName,
        ));

        try {
          final response = await _userPrescriptionServices.getAllPrescriptions(
              token: userLocalDataList[0].token,
              userId: userLocalDataList[0].id);
          if (response.statusCode == 200 || response.statusCode == 201) {
            log(response.toString());
            final responseData =
                UserPrescriptonsResponseModel.fromJson(response.data);
            prescriptionsList = responseData.prescription;
            log(responseData.prescription.toString());
            emit(HomePageFetchDoctorsSuccessState(
              prescriptionList: prescriptionsList,
              appointmentList: appointmentsList,
              departmentList: departmentsList,
              doctorList: doctorsList,
              userImage: userLocalDataList[0].image,
              userName: userLocalDataList[0].firstName,
            ));
          }
        } catch (e) {
          if (e is DioError) {
            showSnackBar(
              text: e.response!.data['message'],
              context: context,
              duration: 3000,
            );
          }
        }
      } catch (e) {
        if (e is DioError) {
          showSnackBar(
            text: e.response!.data['message'],
            context: context,
            duration: 3000,
          );
        }
      }
    });

    add(HomepageEvent());
    on<HomePageNavigateToDepartments>((event, emit) {
      emit(HomePageNavigateToDepartmentsState(
          department: event.department, currentIndex: event.currentIndex));
    });
  }
}
