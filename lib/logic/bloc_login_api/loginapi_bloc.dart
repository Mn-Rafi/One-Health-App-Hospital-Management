import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:one_health_hospital_app/repositories/connectivity_services/connectivity_services.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_response_model.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_services.dart';

part 'loginapi_event.dart';
part 'loginapi_state.dart';

class LoginapiBloc extends Bloc<LoginapiEvent, LoginapiState> {
  final ConnectivityServices _connectivityServices;
  final UserLoginServices _userLoginServices;
  LoginapiBloc(
    this._connectivityServices,
    this._userLoginServices,
  ) : super(LoginapiLoading()) {
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
          emit(LoginapiLoadedState(
              user: response.user,
              token: response.token,
              message: response.message));
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
        if (responseFrom.statusCode == 200) {
          final response = userLoginResponseModelFromJson(responseFrom.data);
          emit(VerifyOtpSuccessState(
            user: response.user,
            token: response.token,
            message: response.message,
          ));
        } else {
          throw DioError;
        }
      } catch (e) {
        if (e is DioError) {
          emit(VerifyOTPfailedState(message: e.response!.data["message"]));
        }
      }
    });
    on<LoginapiEvent>((event, emit) {});
  }
}
