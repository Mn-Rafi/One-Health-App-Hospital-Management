import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final IconData? sufficiconData;
  final String hintText;
  final TextInputType keyBoardType;
  final IconData? iconData;
  final bool obscure;
  final VoidCallback? suffixAction;
  final TextInputAction? nextAction;
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
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
