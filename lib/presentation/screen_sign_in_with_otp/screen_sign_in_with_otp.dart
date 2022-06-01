import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_sign_in_with_otp/screen_verify_otp.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class ScreenSignInwithOtp extends StatelessWidget with TextFieldValidator {
  ScreenSignInwithOtp({Key? key}) : super(key: key);

  static TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                    width: 100.w,
                  ),
                  Text(
                    'Hello Again!',
                    style: mainHeaderStyle,
                  ),
                  Text(
                    'Please provide the registered mobile number',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const CustomImageCard(
                      imagePath: 'images/sign_with_otp.jpg',
                      ratio: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                    child: CustomTextFormField(
                        validator: (val) {
                          return isMobileValid(val);
                        },
                        hintText: 'Mobile number',
                        keyBoardType: TextInputType.number,
                        iconData: Icons.phone,
                        textController: mobileNumberController),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print('ready to api post');
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ScreenVerifyOTP(),
                                type: PageTransitionType.rightToLeft));
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                      child: const CustomSubmitButton(
                          text: 'SEND OTP', bgColor: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
