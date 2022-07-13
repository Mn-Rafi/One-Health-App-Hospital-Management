import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit() : super(SplashscreenInitial()) {
    emit(InitailSplashState());
    Future.delayed(const Duration(seconds: 3)).then((value) {
      SharedPreferences.getInstance().then((value) {
        if (value.getBool('isLoggedIn') == true ||
            value.getBool('isLoggedIn') != null) {
          emit(NavigateToHome());
        } else {
          emit(SplashscreenEnd());
        }
      });
      // emit(SplashscreenEnd());
    });
  }
}
