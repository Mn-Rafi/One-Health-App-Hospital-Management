import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signinfirst_state.dart';

class SigninfirstCubit extends Cubit<SigninfirstState> {
  SigninfirstCubit() : super(PasswordHide());
  void showPassword() {
    emit(PasswordShow());
  }

  void hidePassword() {
    emit(PasswordHide());
  }
}
