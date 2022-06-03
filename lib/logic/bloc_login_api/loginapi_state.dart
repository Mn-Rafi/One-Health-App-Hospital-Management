part of 'loginapi_bloc.dart';

@immutable
abstract class LoginapiState {}

class LoginapiNoInternetState extends LoginapiState {}

class LoginapiLoadState extends LoginapiState {}

class LoginapiLoading extends LoginapiState {}

class LoginapiLoadedState extends LoginapiState {
  final User user;
  final String token;
  final String message;
  LoginapiLoadedState({
    required this.user,
    required this.token,
    required this.message,
  });
}

class LoginapiErrorState extends LoginapiState {
  final String message;
  LoginapiErrorState({
    required this.message,
  });
}

class RequestapiErrorState extends LoginapiState {
  final String message;
  RequestapiErrorState({
    required this.message,
  });
}

class ResendapiErrorState extends LoginapiState {
  final String message;
  ResendapiErrorState({
    required this.message,
  });
}

class RequestOtpState extends LoginapiState {}

class RequestOtpSuccessState extends LoginapiState {
  final String message;
  RequestOtpSuccessState({
    required this.message,
  });
}

class ResendOtpSuccessState extends LoginapiState {
  final String message;
  ResendOtpSuccessState({
    required this.message,
  });
}

class RequestOTPfailedState extends LoginapiState {}

class ResendOTPfailedState extends LoginapiState {}

class VerifyOtpState extends LoginapiState {}

class VerifyOtpSuccessState extends LoginapiState {
  final User user;
  final String token;
  final String message;
  VerifyOtpSuccessState({
    required this.user,
    required this.token,
    required this.message,
  });
}

class VerifyOTPfailedState extends LoginapiState {
  final String message;
  VerifyOTPfailedState({
    required this.message,
  });
}

class ResendOtpInitialised extends LoginapiState {}

class ResendOtpEnd extends LoginapiState {}
