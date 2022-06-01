import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register_two.dart';
import 'package:one_health_hospital_app/presentation/screen_sign_in/screen_sign_in.dart';

part 'welcomescreen_state.dart';

class WelcomescreenCubit extends Cubit<WelcomescreenState> {
  WelcomescreenCubit() : super(WelcomescreenInitial());

  void intialState() {
    emit(WelcomescreenInitial());
  }

  void welcomeScreenSignIn() {
    SignInPageBodyWidget.emailController.text = '';
    SignInPageBodyWidget.passwordController.text = '';
    emit(WelcomeScreenNavLoadSIgnIn());
  }

  void welcomeScreenRegister() {
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

    emit(WelcomeScreenNavLoadRegister());
  }

  void backtoScreen() {
    emit(WelcomescreenBack());
  }
}
