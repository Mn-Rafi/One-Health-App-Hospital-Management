part of 'getprofiledata_bloc.dart';

@immutable
abstract class GetprofiledataState {}

class GetprofiledataInitial extends GetprofiledataState {}

class FetchingProfileDetailState extends GetprofiledataState {}

class UpdateProfileLoadingState extends GetprofiledataState {
  final String message;
  UpdateProfileLoadingState({required this.message});
}

class UpdateProfileSuccess extends GetprofiledataState {
  final String message;
  UpdateProfileSuccess({
    required this.message,
  });
}

class FetchProfileDetailsSuccessState extends GetprofiledataState {
  final User profileData;
  FetchProfileDetailsSuccessState({
    required this.profileData,
  });
}

class FetchDetailsErrorState extends GetprofiledataState {
  final String message;
  FetchDetailsErrorState({
    required this.message,
  });
}

class ChangeUserPasswordStartedState extends GetprofiledataState {
  final String message;
  ChangeUserPasswordStartedState({
    required this.message,
  });
}

class ChangeUserPasswordSuccessState extends GetprofiledataState {
  final String message;
  ChangeUserPasswordSuccessState({
    required this.message,
  });
}

class ChangeUserPasswordErrorState extends GetprofiledataState {
  final String message;
  ChangeUserPasswordErrorState({
    required this.message,
  });
}
