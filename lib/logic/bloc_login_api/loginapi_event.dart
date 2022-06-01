part of 'loginapi_bloc.dart';

@immutable
abstract class LoginapiEvent {}

class LoginapieventEvent extends LoginapiEvent{}

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
