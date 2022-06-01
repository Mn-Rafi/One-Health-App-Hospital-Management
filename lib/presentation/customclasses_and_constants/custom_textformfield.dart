import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:one_health_hospital_app/themedata.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final IconData? sufficiconData;
  final String hintText;
  final TextInputType keyBoardType;
  final IconData? iconData;
  final bool obscure;
  final VoidCallback? suffixAction;
  final TextInputAction? nextAction;
  final TextCapitalization? textCapitalisation;
  const CustomTextFormField({
    Key? key,
    this.validator,
    this.sufficiconData,
    required this.hintText,
    required this.keyBoardType,
    required this.iconData,
    this.obscure = false,
    this.suffixAction,
    this.nextAction,
    this.textCapitalisation,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalisation ?? TextCapitalization.none,
      textInputAction: nextAction ?? TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscure,
      controller: textController,
      keyboardType: keyBoardType,
      validator: validator,
      keyboardAppearance: Brightness.dark,
      style: GoogleFonts.ubuntu(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap: suffixAction ?? () {},
            child: Icon(
              sufficiconData,
              size: 17.sp,
              color: kPrimaryColor,
            )),
        prefixIcon: Icon(
          iconData,
          size: 17.sp,
          color: kPrimaryColor,
        ),
        hintStyle: normalTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class CustomSmallTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final IconData? sufficiconData;
  final String hintText;
  final TextInputType keyBoardType;
  final IconData? iconData;
  final bool obscure;
  final VoidCallback? suffixAction;
  final bool? isEnabled;
  final TextInputAction? nextAction;
  const CustomSmallTextFormField({
    Key? key,
    this.validator,
    this.sufficiconData,
    required this.hintText,
    required this.keyBoardType,
    required this.iconData,
    this.obscure = false,
    this.suffixAction,
    this.isEnabled,
    this.nextAction,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: nextAction ?? TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscure,
      maxLength: 3,
      enabled: isEnabled ?? true,
      controller: textController,
      keyboardType: keyBoardType,
      validator: validator,
      keyboardAppearance: Brightness.dark,
      style: GoogleFonts.ubuntu(color: Colors.black),
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: Icon(
          iconData,
          size: 17.sp,
          color: kPrimaryColor,
        ),
        hintStyle: normalTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
