import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'welcomescreen_state.dart';

class WelcomescreenCubit extends Cubit<WelcomescreenState> {
  WelcomescreenCubit() : super(WelcomescreenInitial());
  void welcomeScreenSignIn() {
    emit(WelcomeScreenNavLoadSIgnIn());
  }

  void welcomeScreenRegister() {
    emit(WelcomeScreenNavLoadRegister());
  }

  void backtoScreen() {
    emit(WelcomescreenBack());
  }
}
