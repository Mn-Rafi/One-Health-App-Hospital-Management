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
