import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/logic/bloc_login_api/loginapi_bloc.dart';
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
                        nextAction: TextInputAction.done,
                        textController: mobileNumberController),
                  ),
                  BlocConsumer<LoginapiBloc, LoginapiState>(
                    listener: (context, state) {
                      if (state is RequestOtpState) {
                        showSnackBar(
                            text: 'Checking details', context: context);
                      }
                      if (state is LoginapiNoInternetState) {
                        showSnackBar(
                            text: 'No internet found', context: context);
                      }
                      if (state is RequestOtpSuccessState) {
                        showSnackBar(
                            text: 'Otp send successfully', context: context);
                        Navigator.of(context).push(PageTransition(
                            child: ScreenVerifyOTP(),
                            type: PageTransitionType.rightToLeft));
                      }
                      if (state is RequestapiErrorState) {
                        showSnackBar(text: state.message, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is RequestOtpState) {
                        return CustomLoadingSubmitButton(
                            text: 'SEND OTP', bgColor: Colors.blue);
                      }
                      return GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print('ready to api post');
                            context.read<LoginapiBloc>().add(RequestOtp(
                                number: mobileNumberController.text));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 10.w),
                          child: const CustomSubmitButton(
                              text: 'SEND OTP', bgColor: Colors.blue),
                        ),
                      );
                    },
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
