import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class CustomStylishWhiteButton extends StatelessWidget {
  final int value;
  final String text;
  const CustomStylishWhiteButton({
    Key? key,
    required this.value,
    required this.text,
    required this.colorCount,
  }) : super(key: key);

  final int? colorCount;
  @override
  Widget build(BuildContext context) {
    final Color? buttonColor =
        colorCount == value ? Colors.blue[100] : Colors.white;
    return Card(
      color: Colors.transparent,
      shadowColor: colorCount == value ? Colors.blue[100] : Colors.white,
      elevation: colorCount == value ? 0 : 4,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.w),
          color: isLightTheme(context) ? buttonColor : Colors.purple,
        ),
        height: 7.h,
        width: 33.w,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.ubuntu(fontSize: 13.sp),
        ),
      ),
    );
  }
}
