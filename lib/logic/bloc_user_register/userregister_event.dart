part of 'userregister_bloc.dart';

@immutable
abstract class UserregisterEvent {}

class UserRegisterApiEvent extends UserregisterEvent {}

class UserRegisterSubmit extends UserregisterEvent {
  final UserRegisterInputModel inputModel;
  UserRegisterSubmit({
    required this.inputModel,
  });
}
