import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/cubit_welcome_screen/welcomescreen_cubit.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class Screenregister extends StatelessWidget {
  const Screenregister({Key? key}) : super(key: key);

  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController secondNameController = TextEditingController();
  static TextEditingController ageController = TextEditingController();
  static TextEditingController bloodGroupController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController mobileController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const ScreenSigninOrRegister(),
                type: PageTransitionType.leftToRight,
                alignment: Alignment.center),
            (route) => false,
          );
          return true;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                      hintText: 'First name',
                      keyBoardType: TextInputType.name,
                      iconData: Icons.person,
                      textController: firstNameController),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                      hintText: 'Second name',
                      keyBoardType: TextInputType.name,
                      iconData: Icons.person,
                      textController: secondNameController),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w,),
                      child: SizedBox(
                        width: 35.w,
                        child: CustomTextFormField(
                            hintText: 'Age',
                            keyBoardType: TextInputType.number,
                            iconData: Icons.person,
                            textController: ageController),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SizedBox(
                        width: 35.w,
                        child: CustomTextFormField(
                            hintText: 'Blood group',
                            keyBoardType: TextInputType.name,
                            iconData: Icons.person,
                            textController: bloodGroupController),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                      hintText: 'Email',
                      keyBoardType: TextInputType.emailAddress,
                      iconData: Icons.person,
                      textController: emailController),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                      hintText: 'Mobile number',
                      keyBoardType: TextInputType.number,
                      iconData: Icons.person,
                      textController: mobileController),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                      obscure: true,
                      hintText: 'Password',
                      keyBoardType: TextInputType.text,
                      iconData: Icons.person,
                      textController: passwordController),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                      obscure: true,
                      hintText: 'Confirm Password',
                      keyBoardType: TextInputType.text,
                      iconData: Icons.person,
                      textController: confirmPasswordController,
                      nextAction: TextInputAction.done),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
