part of 'loginapi_bloc.dart';

@immutable
abstract class LoginapiEvent {}

class LoginapieventEvent extends LoginapiEvent {}

class LoginapiinitialEvent extends LoginapiEvent {
  final String email;
  final String password;
  LoginapiinitialEvent({
    required this.email,
    required this.password,
  });
}

class LoginapiNoInternetEvent extends LoginapiEvent {}

class LoginapiLoadEvent extends LoginapiEvent {}

class LoginapiLoadedEvent extends LoginapiEvent {}

class RequestOtp extends LoginapiEvent {
  final String number;
  RequestOtp({
    required this.number,
  });
}

class VerifyOtp extends LoginapiEvent {
  final String number;
  final int otp;
  VerifyOtp({
    required this.number,
    required this.otp,
  });
}
