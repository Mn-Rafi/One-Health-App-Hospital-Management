part of 'userregister_bloc.dart';

@immutable
abstract class UserregisterState {}

class UserregisterInitial extends UserregisterState {}

class UserRegisterSubmittedState extends UserregisterState {}

class UserRegisterSuccessState extends UserregisterState {
  final String message;
  UserRegisterSuccessState({
    required this.message,
  });
}


class UserRegisterFailedState extends UserregisterState {
  final String message;
  UserRegisterFailedState({
    required this.message,
  });
}
