import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:one_health_hospital_app/presentation/screen_sign_in_with_otp/screen_verify_otp.dart';

import 'package:one_health_hospital_app/repositories/connectivity_services/connectivity_services.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_response_model.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

part 'loginapi_event.dart';
part 'loginapi_state.dart';

class LoginapiBloc extends Bloc<LoginapiEvent, LoginapiState> {
  final ConnectivityServices _connectivityServices;
  final UserLoginServices _userLoginServices;
  LoginapiBloc(
    this._connectivityServices,
    this._userLoginServices,
  ) : super(LoginapiLoading()) {
    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    _connectivityServices.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(LoginapiNoInternetEvent());
      } else {
        add(LoginapieventEvent());
      }
    });
    on<LoginapiNoInternetEvent>((event, emit) {
      emit(LoginapiNoInternetState());
    });
    on<LoginapiLoadEvent>((event, emit) {
      emit(LoginapiLoadState());
    });
    on<LoginapiinitialEvent>((event, emit) async {
      emit(LoginapiLoadState());
      try {
        final Response responseFrom = await _userLoginServices
            .getUserResponseData(email: event.email, password: event.password);
        if (responseFrom.statusCode == 200) {
          final response = userLoginResponseModelFromJson(responseFrom.data);
          print('ID : ${response.user.id}');
          print('TOKEN : ${response.token}');
          emit(LoginapiLoadedState(
              user: response.user,
              token: response.token,
              message: response.message));
          await userLocalData.clear();
          await userLocalData.add(UserLocalData(
            token: response.token,
            id: response.user.id,
            age: response.user.age,
            blood: response.user.blood,
            email: response.user.email,
            firstName: response.user.firstName,
            gender: response.user.gender,
            image: response.user.image,
            password: response.user.password,
            phone: response.user.phone,
            secondName: response.user.secondName,
          ));
          print(userLocalData.values.toList()[0].firstName);
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(LoginapiErrorState(message: e.response!.data["message"]));
        }
      }
    });
    on<RequestOtp>((event, emit) async {
      emit(RequestOtpState());
      try {
        final Response responseFrom =
            await _userLoginServices.requestOtp(number: event.number);
        if (responseFrom.statusCode == 200) {
          emit(RequestOtpSuccessState(message: 'Successfully send otp'));
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(RequestapiErrorState(message: e.response!.data["message"]));
        }
      }
    });
    on<VerifyOtp>((event, emit) async {
      emit(VerifyOtpState());
      try {
        final Response responseFrom = await _userLoginServices.verifyOtp(
            mobileNumber: event.number, otp: event.otp);
        if (responseFrom.statusCode == 200 || responseFrom.statusCode == 202) {
          final response = userLoginResponseModelFromJson(responseFrom.data);
          emit(VerifyOtpSuccessState(
            user: response.user,
            token: response.token,
            message: response.message,
          ));
          await userLocalData.clear();
          await userLocalData.add(UserLocalData(
            token: response.token,
            id: response.user.id,
            age: response.user.age,
            blood: response.user.blood,
            email: response.user.email,
            firstName: response.user.firstName,
            gender: response.user.gender,
            image: response.user.image,
            password: response.user.password,
            phone: response.user.phone,
            secondName: response.user.secondName,
          ));
        } else {
          print(responseFrom.data);
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(VerifyOTPfailedState(message: e.response!.data["message"]));
        }
      }
    });
    on<ResendOtpEVent>((event, emit) async {
      ScreenVerifyOTP.controller.start();
      emit(ResendOtpInitialised());

      try {
        final Response responseFrom =
            await _userLoginServices.requestOtp(number: event.number);
        if (responseFrom.statusCode == 200) {
          emit(ResendOtpSuccessState(message: 'Successfully sent otp'));
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(ResendapiErrorState(message: e.response!.data["message"]));
        }
      }
      await Future.delayed(const Duration(seconds: 30)).then((value) {
        emit(ResendOtpEnd());
      });
    });
    on<LoginapiEvent>((event, emit) {});
  }
}
