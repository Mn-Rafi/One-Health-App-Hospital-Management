import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit() : super(SplashscreenInitial()) {
    emit(ChummaState());
    Future.delayed(const Duration(seconds: 3))
        .then((value) => emit(SplashscreenEnd()));
  }
}
