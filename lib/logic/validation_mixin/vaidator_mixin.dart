mixin TextFieldValidator {
  String? isEmailValid(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "email can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "please enter a valid email";
    } else {
      return null;
    }
  }

  String? isValid({required String? value, required String nameOFFiled}) {
    if (value!.isEmpty) {
      return "$nameOFFiled can't be empty";
    } else {
      return null;
    }
  }

  String? isPasswordValid(String? value) {
    RegExp passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.length < 8) {
      return "password must contain 8 characters";
    } else if (!passwordValid.hasMatch(value)) {
      return 'the password format not correct';
    } else {
      return null;
    }
  }

  String? isMobileValid(String? value) {
    String pattern = r'^[6789]\d{9}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "mobile can't be empty";
    }
    if (value.length < 10 || value.length > 10 || !regExp.hasMatch(value)) {
      return "please enter a valid mobile number";
    } else {
      return null;
    }
  }

  String? isNameValid(String? value, String? type) {
    if (value!.isEmpty) {
      return "$type can't be empty";
    }
    if (value.isNotEmpty && value.length < 3) {
      return "please enter a valid $type";
    } else {
      return null;
    }
  }

  String? isAgeValid(String? value) {
    RegExp regExp = RegExp(r'^[0-9]+$');
    if (value!.isEmpty) {
      return "age can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "not a valid age";
    } else {
      return null;
    }
  }

  String? isSelectedValue(String? value, String? type) {
    if (value!.isEmpty) {
      return 'please select a $type';
    } else {
      return null;
    }
  }
}
