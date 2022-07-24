import 'dart:developer';
// import 'dart:io';
// import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/logic/bloc_home_page/homepage_bloc.dart';
import 'package:one_health_hospital_app/logic/models/user_profile_model.dart';
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
    GetPrfoleResponseModel? profileresponse;
    on<FetchUserProfileDetails>((event, emit) async {
      emit(FetchingProfileDetailState());
      try {
        final Response responseForm =
            await _getUserProfileServices.getUserProfileDetails(
          token: userLocalDataList[0].token,
          id: userLocalDataList[0].id,
        );
        if (responseForm.statusCode == 200) {
          profileresponse = GetPrfoleResponseModel.fromJson(responseForm.data);
          log(responseForm.toString());
          emit(FetchProfileDetailsSuccessState(
              profileData: profileresponse!.user!));
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

    on<ChangeUserPasswordEvent>((event, emit) async {
      emit(ChangeUserPasswordStartedState(message: 'Checking Details'));
      try {
        final response = await _getUserProfileServices.changeUserPassword(
          token: userLocalDataList[0].token,
          id: userLocalDataList[0].id,
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );
        if (response.statusCode == 200) {
          emit(ChangeUserPasswordSuccessState(message: 'Password Changed'));
          emit(FetchProfileDetailsSuccessState(
              profileData: profileresponse!.user!));
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(ChangeUserPasswordErrorState(
              message: e.response!.data["message"]));
          emit(FetchProfileDetailsSuccessState(
              profileData: profileresponse!.user!));
        }
        debugPrint(e.toString());
      }
    });

    on<UpdateAccountEvent>((event, emit) async {
      emit(UpdateProfileLoadingState(message: 'Updating Details'));
      try {
        final response = await _getUserProfileServices.editProfile(
          isImageChaned: event.isImageChanged,
          token: userLocalDataList[0].token,
          id: userLocalDataList[0].id,
          editProfileModel: event.editProfileModel,
        );
        if (response.statusCode == 201) {
          log(response.data.toString());
          emit(UpdateProfileLoadingState(message: 'Profile Updated'));
          event.context.read<HomepageBloc>().add(HomepageEvent());
          add(FetchUserProfileDetails());
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(FetchDetailsErrorState(message: e.toString()));
        }

        emit(FetchDetailsErrorState(message: e.toString().substring(0, 30)));
        add(FetchUserProfileDetails());
        debugPrint(e.toString());
      }
    });

    on<GetprofiledataEvent>((event, emit) {});
  }
}
