import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  final getBox = GetStorage();
  SplashscreenCubit() : super(SplashscreenInitial()) {
    emit(InitailSplashState());
    Future.delayed(const Duration(seconds: 3)).then((value) {
      // SharedPreferences.getInstance().then((value) {
      //   if (value.getBool('isLoggedIn') == true ||
      //       value.getBool('isLoggedIn') != null) {
      //     emit(NavigateToHome());
      //   } else if (value.getBool('isLoggedIn') == false ||
      //       value.getBool('isLoggedIn') == null) {
      //     emit(SplashscreenEnd());
      //   }
      // });
      // GetStorage.getInstance().then((value) {
      //   if (value.getBool('isLoggedIn') == true ||
      //       value.getBool('isLoggedIn') != null) {
      //     emit(NavigateToHome());
      //   } else if (value.getBool('isLoggedIn') == false ||
      //       value.getBool('isLoggedIn') == null) {
      //     emit(SplashscreenEnd());
      //   }
      // });getBox
      final value = getBox.read('isLoggedIn');

      if (value == true) {
        emit(NavigateToHome());
      } else {
        emit(SplashscreenEnd());
      }
    });
  }
}
