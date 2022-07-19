import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? fontColr;
  const CustomSubmitButton(
      {Key? key,
      required this.text,
      required this.bgColor,
      this.height,
      this.fontSize,
      this.fontColr,
      this.borderRadius,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 50.w,
      height: height ?? 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 2.w),
        color: bgColor,
      ),
      child: Text(
        text,
        style: GoogleFonts.ubuntu(
            color: fontColr ?? Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: fontSize ?? 14.sp),
      ),
    );
  }
}

class CustomLoadingSubmitButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  const CustomLoadingSubmitButton({
    Key? key,
    required this.text,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50.w,
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: bgColor,
      ),
      child: SizedBox(
          height: 2.5.h,
          width: 2.5.h,
          child: const CircularProgressIndicator(
            color: Colors.white,
          )),
    );
  }
}
