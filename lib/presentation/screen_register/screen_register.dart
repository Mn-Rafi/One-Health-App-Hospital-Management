import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_register/blood_groups_alert_dialogue.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                  width: 100.w,
                ),
                Text(
                  'Personal Info',
                  style: mainHeaderStyle,
                ),
                Text(
                  'Step 1 of 2',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      color: Colors.deepOrange,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  height: 30.h,
                  width: 60.w,
                  child: Stack(
                    children: [
                      const CustomCircularImageCard(
                        imagePath: 'images/circle_avatar.jpg',
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomCircularImageCard(
                            imagePath: 'images/add_image_icon.png',
                            radius: 6.w,
                          )),
                    ],
                  ),
                ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        child: SizedBox(
                          width: 34.w,
                          child: CustomSmallTextFormField(
                              nextAction: TextInputAction.done,
                              hintText: 'Age',
                              keyBoardType: TextInputType.number,
                              iconData: Icons.nature_people_outlined,
                              textController: ageController),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => BloodGroupAlertBox());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: SizedBox(
                            width: 42.w,
                            child: CustomSmallTextFormField(
                                isEnabled: false,
                                hintText: 'Blood group',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.bloodtype,
                                textController: bloodGroupController),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                // RegisterBodyDemo(
                //   firstNameController: firstNameController,
                //   secondNameController: secondNameController,
                //   ageController: ageController,
                //   bloodGroupController: bloodGroupController,
                //   emailController: emailController,
                //   mobileController: mobileController,
                //   passwordController: passwordController,
                //   confirmPasswordController: confirmPasswordController,
                // ),
                ),
          ),
        ),
      ),
    );
  }
}

class RegisterBodyDemo extends StatelessWidget {
  const RegisterBodyDemo({
    Key? key,
    required this.firstNameController,
    required this.secondNameController,
    required this.ageController,
    required this.bloodGroupController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController firstNameController;
  final TextEditingController secondNameController;
  final TextEditingController ageController;
  final TextEditingController bloodGroupController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          child: CustomTextFormField(
              hintText: 'First name',
              keyBoardType: TextInputType.name,
              iconData: Icons.person,
              textController: firstNameController),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
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
              padding: EdgeInsets.only(
                left: 10.w,
              ),
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
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          child: CustomTextFormField(
              hintText: 'Email',
              keyBoardType: TextInputType.emailAddress,
              iconData: Icons.person,
              textController: emailController),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          child: CustomTextFormField(
              hintText: 'Mobile number',
              keyBoardType: TextInputType.number,
              iconData: Icons.person,
              textController: mobileController),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          child: CustomTextFormField(
              obscure: true,
              hintText: 'Password',
              keyBoardType: TextInputType.text,
              iconData: Icons.person,
              textController: passwordController),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          child: CustomTextFormField(
              obscure: true,
              hintText: 'Confirm Password',
              keyBoardType: TextInputType.text,
              iconData: Icons.person,
              textController: confirmPasswordController,
              nextAction: TextInputAction.done),
        ),
      ],
    );
  }
}
