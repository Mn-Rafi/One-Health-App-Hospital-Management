import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:one_health_hospital_app/presentation/screen_book_appointment/appointment_slot_by_date_response_model.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_appointment_services.user_appointment_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

part 'user_appointment_event.dart';
part 'user_appointment_state.dart';

class UserAppointmentBloc
    extends Bloc<UserAppointmentEvent, UserAppointmentState> {
      final UserAppointmentServices _userAppointmentServices;
  UserAppointmentBloc(this._userAppointmentServices) : super(UserAppointmentInitial()) {
    
    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    final List<UserLocalData> userLocalDataList = userLocalData.values.toList();
    on<UserAppointmentByDate>((event, emit) async {
      try{
final Response response = await _userAppointmentServices.getAppoiByDtae(
        token: userLocalDataList[0].token,
        doctorId: event.doctorId,
        dateTime: event.dateTime,
      );
      if(response.statusCode == 200){
        final appointmentSlotByDateResponse = appointmentSlotByDateResponseFromJson(response.data.toString()); 
        emit(UserAppointmentByDateState(
          appointmentSlotByDateResponse: appointmentSlotByDateResponse,
        ));
      }else{
        throw DioError;
      }
      } catch (e) {
        if(e is DioError){
          showSnackBar(
            text: e.response!.data['message'],
            context: event.context,
            duration: 3000,
          );
        }
      }
    });
    // add(UserAppointmentByDate(dateTime: DateTime.now()));
  }
}
