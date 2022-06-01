part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class PickImageStart extends RegisterState {}

class PickImageEnd extends RegisterState {
  final String? fileImagePath;
  PickImageEnd({
    required this.fileImagePath,
  });
}

class BloodGroupNotSelected extends RegisterState {}

class GenderNotSelected extends RegisterState {}

class ImageNotSelected extends RegisterState {}

class ScreenOneValid extends RegisterState {}

class ShowPassword extends RegisterState {}

class HidePassword extends RegisterState {}

class PasswordDonoMatch extends RegisterState {}

class FrontEndValidationSucces extends RegisterState {}
