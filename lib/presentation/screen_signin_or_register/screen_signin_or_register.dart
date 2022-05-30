import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/cubit_welcome_screen/welcomescreen_cubit.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_stylish_white_button.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';
import 'package:one_health_hospital_app/presentation/screen_sign_in/screen_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenSigninOrRegister extends StatelessWidget {
  const ScreenSigninOrRegister({Key? key}) : super(key: key);

  static int? colorCount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomescreenCubit(),
      child: Container(
        decoration: kboxdecoration,
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPaddingheight,
                horizontal: kDefaultPaddingwidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomImageCard(
                    imagePath: 'images/signin_or_register.jpg', ratio: 1.2),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Text(
                    'Welcome To \nOne Health App',
                    textAlign: TextAlign.center,
                    style: mainHeaderStyle,
                  ),
                ),
                Text(
                  "An app for your health. \nNow the doctors are live in your phone",
                  textAlign: TextAlign.center,
                  style: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? normalTextStyle
                      : normalTextStyledark,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: BlocConsumer<WelcomescreenCubit, WelcomescreenState>(
                    listener: (context, state) {
                      if (state is WelcomeScreenNavLoadSIgnIn) {
                        Future.delayed(const Duration(milliseconds: 100))
                            .then((value) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const ScreenSignIn(),
                                  type: PageTransitionType.rightToLeft,
                                  alignment: Alignment.center));
                        });
                      }
                      if (state is WelcomeScreenNavLoadRegister) {
                        Future.delayed(const Duration(milliseconds: 100))
                            .then((value) {
                          Screenregister.bloodGroupController.text = '';
                          Screenregister.ageController.text = '';
                          Screenregister.firstNameController.text = '';
                          Screenregister.secondNameController.text = '';
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const Screenregister(),
                                  type: PageTransitionType.rightToLeft,
                                  alignment: Alignment.center));
                        });
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        height: 7.h,
                        width: 70.w,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: state is WelcomeScreenNavLoadRegister
                                  ? () {}
                                  : () {
                                      colorCount = 1;
                                      context
                                          .read<WelcomescreenCubit>()
                                          .welcomeScreenRegister();
                                    },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CustomStylishWhiteButton(
                                  colorCount: state is WelcomescreenBack
                                      ? 0
                                      : colorCount,
                                  text: 'Register',
                                  value: 1,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: state is WelcomeScreenNavLoadSIgnIn
                                  ? () {}
                                  : () {
                                      colorCount = 2;
                                      context
                                          .read<WelcomescreenCubit>()
                                          .welcomeScreenSignIn();
                                    },
                              child: CustomStylishWhiteButton(
                                colorCount:
                                    state is WelcomescreenBack ? 0 : colorCount,
                                text: 'Sign In',
                                value: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
