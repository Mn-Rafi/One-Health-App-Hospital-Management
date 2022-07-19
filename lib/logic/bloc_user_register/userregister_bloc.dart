import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:one_health_hospital_app/repositories/user_register/user_register_data.dart';
import 'package:one_health_hospital_app/repositories/user_register/user_register_services.dart';

part 'userregister_event.dart';
part 'userregister_state.dart';

class UserregisterBloc extends Bloc<UserregisterEvent, UserregisterState> {
  final UserRegisterServices _userRegisterServices;
  UserregisterBloc(
    this._userRegisterServices,
  ) : super(UserregisterInitial()) {
    on<UserRegisterSubmit>((event, emit) async {
      emit(UserRegisterSubmittedState());
      try {
        final Response responseForm = await _userRegisterServices
            .getUserRegisterResponse(inputs: event.inputModel);
        if (responseForm.statusCode == 201) {
          emit(UserRegisterSuccessState(message: 'Succesefully Registered'));
        } else {
          throw DioError;
        }
      } catch (e) {
        // emit(UserRegisterFailedState(message: e.toString()));
        if (e is DioError) {
          emit(UserRegisterFailedState(message: e.response!.data["message"]));
        }
      }
    });
    on<UserregisterEvent>((event, emit) {});
  }
}
