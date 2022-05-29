import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  const CustomSubmitButton({
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
      child: Text(
        text,
        style: GoogleFonts.ubuntu(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14.sp),
      ),
    );
  }
}
