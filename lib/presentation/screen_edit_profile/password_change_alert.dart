import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_get_user_profile/getprofiledata_bloc.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
// import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/presentation/screen_edit_profile/custom_text_field.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordAlert extends StatelessWidget with TextFieldValidator {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      // title: Text('Are you sure?'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 80.w,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.MARGIN_SIZE_DEFAULT,
                      left: Dimensions.MARGIN_SIZE_DEFAULT,
                      right: Dimensions.MARGIN_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock_open, color: kPrimaryColor, size: 20),
                          SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                          Text('Enter current password',
                              style: titilliumRegular)
                        ],
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                      CustomPasswordTextField(
                        controller: _currentPasswordController,
                        focusNode: _currentPasswordFocus,
                        nextNode: _passwordFocus,
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.MARGIN_SIZE_DEFAULT,
                      left: Dimensions.MARGIN_SIZE_DEFAULT,
                      right: Dimensions.MARGIN_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock_open, color: kPrimaryColor, size: 20),
                          SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                          Text('Enter a new password', style: titilliumRegular)
                        ],
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                      CustomPasswordTextField(
                        validator: (value) {
                          return isPasswordValid(value);
                        },
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        nextNode: _confirmPasswordFocus,
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),

                // for  re-enter Password
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.MARGIN_SIZE_DEFAULT,
                      left: Dimensions.MARGIN_SIZE_DEFAULT,
                      right: Dimensions.MARGIN_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock_open, color: kPrimaryColor, size: 20),
                          SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                          Text('Confirm password', style: titilliumRegular)
                        ],
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                      CustomPasswordTextField(
                        validator: (value) {
                          return isPasswordValid(value);
                        },
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            if (_confirmPasswordController.text != '' &&
                _passwordController.text != '' &&
                _currentPasswordController.text != '') {
              if (_formKey.currentState!.validate()) {
                context.read<GetprofiledataBloc>().add(ChangeUserPasswordEvent(
                    newPassword: _passwordController.text,
                    oldPassword: _currentPasswordController.text));
                Navigator.pop(context, true);
              }
            } else {
              showSnackBar(
                  text: 'Please fill all the fileds', context: context);
            }
          },
          child: CustomSubmitButton(
            text: 'Change Password',
            bgColor: Colors.redAccent,
            width: 40.w,
            height: 4.h,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
