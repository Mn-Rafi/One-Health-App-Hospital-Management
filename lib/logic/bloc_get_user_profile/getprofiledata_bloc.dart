import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_get_profile/user_get_profile_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

part 'getprofiledata_event.dart';
part 'getprofiledata_state.dart';

class GetprofiledataBloc
    extends Bloc<GetprofiledataEvent, GetprofiledataState> {
  final GetUserProfileServices _getUserProfileServices;
  GetprofiledataBloc(this._getUserProfileServices)
      : super(GetprofiledataInitial()) {
    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    final List<UserLocalData> userLocalDataList = userLocalData.values.toList();
    on<FetchUserProfileDetails>((event, emit) async {
      emit(FetchingProfileDetailState());
      try {
        final Response responseForm =
            await _getUserProfileServices.getUserProfileDetails(
          token: userLocalDataList[0].token,
          id: userLocalDataList[0].id,
        );
        if (responseForm.statusCode == 200) {
          final Map<String, dynamic> response = responseForm.data["user"];
          emit(FetchProfileDetailsSuccessState(
              image: File(userLocalDataList[0].image),
              firstName: response["image"]));
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(FetchDetailsErrorState(message: e.response!.data["message"]));
        }
      }
    });

    add(FetchUserProfileDetails());
    on<GetprofiledataEvent>((event, emit) {});
  }
}
