import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:one_health_hospital_app/themedata.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  void pickImage(ImageSource source) async {
    emit(PickImageStart());
    String? imagePath;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop image',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: Colors.white,
          )
        ],
      );
      if (croppedImage != null) {
        imagePath = croppedImage.path;
        RegisterScreenBody.fileImage = File(croppedImage.path);
      } else {
        imagePath = image.path;
        RegisterScreenBody.fileImage = File(image.path);
      }
    }
    RegisterScreenBody.fleImagePath = imagePath;
    print('imagePath: $imagePath');
    emit(PickImageEnd(fileImagePath: imagePath));
  }

  void bloodGroupNotSelected() {
    emit(BloodGroupNotSelected());
  }

  void genderNotSelected() {
    emit(GenderNotSelected());
  }

  void imageNotSelected() {
    emit(ImageNotSelected());
  }

  void validScreenOne() {
    emit(ScreenOneValid());
  }

  void showPassword() {
    emit(ShowPassword());
  }

  void hidePassword() {
    emit(HidePassword());
  }

  void passwordDonotMatch() {
    emit(PasswordDonoMatch());
  }

  void frontEndValidationSuccess() {
    emit(FrontEndValidationSucces());
  }
}
