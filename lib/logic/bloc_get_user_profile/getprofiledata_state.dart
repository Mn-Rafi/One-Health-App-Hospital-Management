part of 'getprofiledata_bloc.dart';

@immutable
abstract class GetprofiledataState {}

class GetprofiledataInitial extends GetprofiledataState {}

class FetchingProfileDetailState extends GetprofiledataState {}

class FetchProfileDetailsSuccessState extends GetprofiledataState {
  File image;
  final String firstName;

  FetchProfileDetailsSuccessState({
    required this.image,
    required this.firstName,
  });
}

class FetchDetailsErrorState extends GetprofiledataState {
  final String message;
  FetchDetailsErrorState({
    required this.message,
  });
}
