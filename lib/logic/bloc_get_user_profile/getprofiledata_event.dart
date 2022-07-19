part of 'getprofiledata_bloc.dart';

@immutable
abstract class GetprofiledataEvent {}

class FetchUserProfileDetails extends GetprofiledataEvent {}

class ChangeUserPasswordEvent extends GetprofiledataEvent {
  final String oldPassword;
  final String newPassword;
  ChangeUserPasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });
}

class UpdateAccountEvent extends GetprofiledataEvent {
  final bool isImageChanged;
  final EditProfileModel editProfileModel;
  final BuildContext context;
  UpdateAccountEvent({
    required this.context,
    required this.isImageChanged,
    required this.editProfileModel,
  });
}
