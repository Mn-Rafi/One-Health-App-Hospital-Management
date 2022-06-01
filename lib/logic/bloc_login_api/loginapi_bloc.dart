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
        // print('No internet connection');
        add(LoginapiNoInternetEvent());
      } else {
        add(LoginapieventEvent());
        // print('Internet is fine');
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
        final UserLoginResponseModel? response = await _userLoginServices
            .getUserResponseData(email: event.email, password: event.password);
        emit(LoginapiLoadedState(
            user: response!.user,
            token: response.token,
            message: response.message));
      } catch (e) {
        print('Other Error');
        emit(LoginapiNoInternetState());
        print(e);
        if (e is DioError) {
          emit(LoginapiErrorState(message: e.response!.data["message"]));
        }
      }
    });
    on<LoginapiEvent>((event, emit) {});
  }
}
