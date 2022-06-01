import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register_two.dart';

part 'signinfirst_state.dart';

class SigninfirstCubit extends Cubit<SigninfirstState> {
  SigninfirstCubit() : super(PasswordHide());
  void showPassword() {
    emit(PasswordShow());
  }

  void hidePassword() {
    emit(PasswordHide());
  }

  void navigateToRegister() {
    RegisterScreenBody.bloodGroupController.text = '';
    RegisterScreenBody.ageController.text = '';
    RegisterScreenBody.firstNameController.text = '';
    RegisterScreenBody.secondNameController.text = '';
    RegisterScreenBody.genderController.text = '';
    RegisterScreenBody.fleImagePath = null;
    RegisterScreenBodyTwo.emailController.text = '';
    RegisterScreenBodyTwo.mobileController.text = '';
    RegisterScreenBodyTwo.passwordController.text = '';
    RegisterScreenBodyTwo.confirmPasswordController.text = '';
    emit(NavigatetoRegisterScreen());
  }

  void navigateToOtpScreen() {
    emit(NavigatetoOtpLoginScreen());
  }
}
