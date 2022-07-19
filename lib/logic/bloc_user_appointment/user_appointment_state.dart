part of 'user_appointment_bloc.dart';

@immutable
abstract class UserAppointmentState {}

class UserAppointmentInitial extends UserAppointmentState {}

class UserAppointmentByDateState extends UserAppointmentState {
  final AppointmentSlotByDateResponse appointmentSlotByDateResponse;
  final List<UserLocalData> userLocalDataList;
  UserAppointmentByDateState({
    required this.appointmentSlotByDateResponse,
    required this.userLocalDataList,
  });
}

class AppointmentDeleteStatus extends UserAppointmentState {
  final String message;
  AppointmentDeleteStatus({
    required this.message,
  });
}
