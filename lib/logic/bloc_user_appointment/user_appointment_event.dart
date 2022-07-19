part of 'user_appointment_bloc.dart';

@immutable
abstract class UserAppointmentEvent {}

class UserAppointmentByDate extends UserAppointmentEvent {
  final DateTime dateTime;
  final BuildContext context;
  final String doctorId;
  UserAppointmentByDate({
    required this.dateTime,
    required this.context,
    required this.doctorId,
  });
}

class CancelAPpointmentEvent extends UserAppointmentEvent {
  final String appointmentId;
  final String reason;
  final BuildContext context;
  CancelAPpointmentEvent({
    required this.appointmentId,
    required this.reason,
    required this.context,
  });
}
