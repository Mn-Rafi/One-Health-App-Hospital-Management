import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/logic/bloc_login_api/loginapi_bloc.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/screen_sign_in_with_otp/screen_sign_in_with_otp.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class ScreenVerifyOTP extends StatelessWidget {
  ScreenVerifyOTP({Key? key}) : super(key: key);
  TextEditingController newTextEditingController = TextEditingController();

  static TextEditingController otpTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                  'Type the verification code we have sent to \n+91 ${ScreenSignInwithOtp.mobileNumberController.text}',
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
                CustomPinInputField(
                    otpTextController: otpTextController,
                    newTextEditingController: newTextEditingController),
                BlocConsumer<LoginapiBloc, LoginapiState>(
                  listener: (context, state) {
                    if (state is VerifyOtpState) {
                      showSnackBar(text: 'Checking the otp', context: context);
                    }
                    if (state is VerifyOTPfailedState) {
                      showSnackBar(
                        duration: 2000,
                          text:
                              "please enter the correct otp send to the registered mobile number. ${state.message}",
                          context: context);
                    }
                    if (state is VerifyOtpSuccessState) {
                      showSnackBar(text: state.message, context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is VerifyOtpState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 10.w),
                        child: const CustomLoadingSubmitButton(
                            text: 'VERIFY OTP', bgColor: Colors.deepPurple),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        if (otpTextController.text.isNotEmpty) {
                          context.read<LoginapiBloc>().add(VerifyOtp(
                              number: ScreenSignInwithOtp
                                  .mobileNumberController.text,
                              otp: int.parse(otpTextController.text)));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 10.w),
                        child: const CustomSubmitButton(
                            text: 'VERIFY OTP', bgColor: Colors.deepPurple),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPinInputField extends StatelessWidget {
  const CustomPinInputField({
    Key? key,
    required this.otpTextController,
    required this.newTextEditingController,
  }) : super(key: key);

  final TextEditingController otpTextController;
  final TextEditingController newTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: PinCodeTextField(
        keyboardType: TextInputType.number,
        onChanged: (val) {
          otpTextController.text = '';
        },
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 14.w,
          fieldWidth: 12.w,
          activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        controller: newTextEditingController,
        onCompleted: (value) {
          otpTextController.text = value;
          context.read<LoginapiBloc>().add(VerifyOtp(
              number: ScreenSignInwithOtp.mobileNumberController.text,
              otp: int.parse(value)));
        },
      ),
    );
  }
}
