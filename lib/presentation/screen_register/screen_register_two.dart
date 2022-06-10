import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/logic/bloc_user_register/userregister_bloc.dart';
import 'package:one_health_hospital_app/logic/cubit_register/register_cubit.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/repositories/user_register/user_register_data.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RegisterScreenBodyTwo extends StatelessWidget with TextFieldValidator {
  RegisterScreenBodyTwo({
    Key? key,
  }) : super(key: key);

  static TextEditingController emailController = TextEditingController();
  static TextEditingController mobileController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData hidePass = Icons.visibility_off;
  IconData hidePass1 = Icons.visibility_off;
  bool isObscure = true;
  bool isObscure1 = true;

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
                    'User Info',
                    style: mainHeaderStyle,
                  ),
                  Text(
                    'Step 2 of 2',
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
                                    : RegisterScreenBody.fileImage!.path,
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
                        validator: (val) {
                          return isEmailValid(val);
                        },
                        hintText: 'Email',
                        keyBoardType: TextInputType.emailAddress,
                        iconData: Icons.email,
                        textController: emailController),
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
                        textController: mobileController),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                    child: BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is PasswordDonoMatch) {
                          showSnackBar(
                              context: context, text: 'Password do not match');
                        }
                      },
                      builder: (context, state) {
                        return CustomTextFormField(
                            suffixAction: () {
                              if (isObscure == true) {
                                isObscure = false;
                                hidePass = Icons.visibility;
                                context.read<RegisterCubit>().showPassword();
                              } else {
                                isObscure = true;
                                hidePass = Icons.visibility_off;
                                context.read<RegisterCubit>().hidePassword();
                              }
                            },
                            obscure: isObscure,
                            sufficiconData: hidePass,
                            validator: (val) {
                              return isPasswordValid(val);
                            },
                            hintText: 'Password',
                            keyBoardType: TextInputType.name,
                            iconData: Icons.lock,
                            textController: passwordController);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                            suffixAction: () {
                              if (isObscure1 == true) {
                                isObscure1 = false;
                                hidePass1 = Icons.visibility;
                                context.read<RegisterCubit>().showPassword();
                              } else {
                                isObscure1 = true;
                                hidePass1 = Icons.visibility_off;
                                context.read<RegisterCubit>().hidePassword();
                              }
                            },
                            obscure: isObscure1,
                            sufficiconData: hidePass1,
                            validator: (val) {
                              return isPasswordValid(val);
                            },
                            hintText: 'Confirm password',
                            nextAction: TextInputAction.done,
                            keyBoardType: TextInputType.name,
                            iconData: Icons.lock,
                            textController: confirmPasswordController);
                      },
                    ),
                  ),
                  BlocConsumer<UserregisterBloc, UserregisterState>(
                    listener: (context, state) {
                      if (state is UserRegisterSubmittedState) {
                        showSnackBar(
                            text: 'Checking Registered details',
                            context: context);
                      }
                      if (state is UserRegisterFailedState) {
                        if (state.message.contains('phone_1 dup')) {
                          showSnackBar(
                              text: 'The number already have registered',
                              context: context);
                        } else {
                          showSnackBar(text: state.message, context: context);
                        }
                      }
                      if (state is UserRegisterSuccessState) {
                        showSnackBar(text: state.message, context: context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: const ScreenSigninOrRegister(),
                                type: PageTransitionType.fade),
                            (route) => false);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserRegisterSubmittedState) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: const CustomLoadingSubmitButton(
                              text: 'REGISTER', bgColor: Color(0xff5593b7)),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                context
                                    .read<RegisterCubit>()
                                    .passwordDonotMatch();
                              } else {
                                final inputModel = UserRegisterInputModel(
                                  firstName: RegisterScreenBody
                                      .firstNameController.text,
                                  secondName: RegisterScreenBody
                                      .secondNameController.text,
                                  age: int.parse(
                                      RegisterScreenBody.ageController.text),
                                  gender:
                                      RegisterScreenBody.genderController.text,
                                  email: RegisterScreenBodyTwo
                                      .emailController.text,
                                  phone: RegisterScreenBodyTwo
                                      .mobileController.text,
                                  blood: RegisterScreenBody
                                      .bloodGroupController.text,
                                  password: RegisterScreenBodyTwo
                                      .passwordController.text,
                                  image: RegisterScreenBody.fileImage!,
                                );
                                context.read<UserregisterBloc>().add(
                                    UserRegisterSubmit(inputModel: inputModel));
                              }
                            }
                          },
                          child: const CustomSubmitButton(
                            bgColor: Color(0xff5593b7),
                            text: 'REGISTER',
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
      ),
    );
  }
}
