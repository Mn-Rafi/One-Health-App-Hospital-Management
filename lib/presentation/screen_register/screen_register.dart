import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/logic/cubit_register/register_cubit.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_register/blood_groups_alert_dialogue.dart';
import 'package:one_health_hospital_app/presentation/screen_register/gender_radio.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register_two.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Screenregister extends StatelessWidget {
  const Screenregister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Container(
        decoration: kboxdecoration,
        child: RegisterScreenBody(),
      ),
    );
  }
}

class RegisterScreenBody extends StatelessWidget with TextFieldValidator {
  RegisterScreenBody({
    Key? key,
  }) : super(key: key);

  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController secondNameController = TextEditingController();
  static TextEditingController ageController = TextEditingController();
  static TextEditingController bloodGroupController = TextEditingController();
  static TextEditingController genderController = TextEditingController();
  static String? fleImagePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool firstTap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Personal Info',
                  style: mainHeaderStyle,
                ),
                Text(
                  'Step 1 of 2',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      color: Colors.deepOrange,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<RegisterCubit>()
                        .pickImage(ImageSource.gallery);
                  },
                  child: SizedBox(
                    height: 30.h,
                    width: 60.w,
                    child: Stack(
                      children: [
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return CustomCircularImageCard(
                              fileImagePath: state is PickImageEnd
                                  ? state.fileImagePath
                                  : fleImagePath,
                              imagePath: 'images/circle_avatar.jpg',
                            );
                          },
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
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                    textCapitalisation: TextCapitalization.words,
                      validator: (val) {
                        return isNameValid(val, 'first name');
                      },
                      hintText: 'First name',
                      keyBoardType: TextInputType.name,
                      iconData: Icons.person,
                      textController: firstNameController),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  child: CustomTextFormField(
                    textCapitalisation: TextCapitalization.words,
                      validator: (val) {
                        return isNameValid(val, 'second name');
                      },
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
                              validator: (val) {
                                return isAgeValid(val);
                              },
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => GenderAlertBox());
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                    child: SizedBox(
                      width: 100.w,
                      child: CustomSmallTextFormField(
                          isEnabled: false,
                          hintText: 'Gender',
                          keyBoardType: TextInputType.name,
                          iconData: LineIcons.transgender,
                          textController: genderController),
                    ),
                  ),
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is GenderNotSelected) {
                      showSnackBar(
                          context: context, text: 'Please select a gender');
                    }
                    if (state is BloodGroupNotSelected) {
                      showSnackBar(
                          context: context,
                          text: 'Please select a blood group');
                    }
                    if (state is ImageNotSelected) {
                      showSnackBar(
                          context: context,
                          text: 'Please provide a profile image');
                    }
                    if (state is ScreenOneValid) {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: BlocProvider.value(
                                value: context.read<RegisterCubit>(),
                                child: RegisterScreenBodyTwo(),
                              ),
                              type: PageTransitionType.leftToRight));
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: GestureDetector(
                        onTap: () {
                          if (firstTap) {
                            if (_formKey.currentState!.validate()) {
                              if (genderController.text.isNotEmpty &&
                                  bloodGroupController.text.isNotEmpty &&
                                  fleImagePath != null) {
                                context.read<RegisterCubit>().validScreenOne();
                                firstTap = false;
                              }
                              if (fleImagePath == null) {
                                context
                                    .read<RegisterCubit>()
                                    .imageNotSelected();
                              } else if (genderController.text.isEmpty) {
                                context
                                    .read<RegisterCubit>()
                                    .genderNotSelected();
                              } else if (bloodGroupController.text.isEmpty) {
                                context
                                    .read<RegisterCubit>()
                                    .bloodGroupNotSelected();
                              }
                            }
                          }
                        },
                        child: const CustomSubmitButton(
                          bgColor: Color(0xff5593b7),
                          text: 'NEXT',
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
