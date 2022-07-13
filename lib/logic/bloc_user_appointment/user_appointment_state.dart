part of 'user_appointment_bloc.dart';

@immutable
abstract class UserAppointmentState {}

class UserAppointmentInitial extends UserAppointmentState {}

class UserAppointmentByDateState extends UserAppointmentState {
  final AppointmentSlotByDateResponse appointmentSlotByDateResponse;
  UserAppointmentByDateState({
    required this.appointmentSlotByDateResponse,
  });
}
