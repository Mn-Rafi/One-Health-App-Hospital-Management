// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/route_manager.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:one_health_hospital_app/logic/bloc_get_user_profile/getprofiledata_bloc.dart';
// import 'package:one_health_hospital_app/main.dart';
// import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
// import 'package:one_health_hospital_app/presentation/screen_edit_profile/custom_text_field.dart';
// import 'package:one_health_hospital_app/presentation/screen_edit_profile/password_change_alert.dart';
// import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
// import 'package:one_health_hospital_app/presentation/screen_splash/screen_splash.dart';
// import 'package:one_health_hospital_app/repositories/user_get_profile/user_get_profile_services.dart';
// import 'package:one_health_hospital_app/themedata.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';

// class ScreenEditProfile extends StatefulWidget {
//   ScreenEditProfile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ScreenEditProfile> createState() => _ScreenEditProfileState();
// }

// class _ScreenEditProfileState extends State<ScreenEditProfile> {
//   final FocusNode _fNameFocus = FocusNode();

//   final FocusNode _lNameFocus = FocusNode();

//   final FocusNode _ageFocus = FocusNode();

//   final FocusNode _genderFocus = FocusNode();

//   final FocusNode _emailFocus = FocusNode();

//   final FocusNode _phoneFocus = FocusNode();

//   final FocusNode _bloodFocus = FocusNode();

//   final TextEditingController _firstNameController = TextEditingController();

//   final TextEditingController _lastNameController = TextEditingController();

//   final TextEditingController _emailController = TextEditingController();

//   final TextEditingController _phoneController = TextEditingController();

//   final TextEditingController _ageController = TextEditingController();

//   final TextEditingController _bloodController = TextEditingController();

//   final TextEditingController _genderController = TextEditingController();

//   bool isImageChanged = false;
//   final getBox = GetStorage();

//   String? newImagepath;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: kboxdecoration,
//       child: BlocConsumer<GetprofiledataBloc, GetprofiledataState>(
//         listener: (context, state) {
//           if (state is ChangeUserPasswordStartedState) {
//             showSnackBar(text: state.message, context: context);
//           }
//           if (state is ChangeUserPasswordSuccessState) {
//             showSnackBar(text: state.message, context: context);
//           }
//           if (state is ChangeUserPasswordErrorState) {
//             showSnackBar(text: state.message, context: context);
//           }
//           if (state is FetchDetailsErrorState) {
//             showSnackBar(text: state.message, context: context);
//           }
//         },
//         builder: (context, state) {
//           if (state is FetchProfileDetailsSuccessState) {
//             _firstNameController.text = state.profileData.firstName!;
//             _lastNameController.text = state.profileData.secondName!;
//             _emailController.text = state.profileData.email!;
//             _phoneController.text = state.profileData.phone!;
//             _ageController.text = state.profileData.age.toString();
//             _bloodController.text = state.profileData.blood!;
//             _genderController.text = state.profileData.gender!;

//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text('Profile', style: TextStyle(color: Colors.black)),
//                   elevation: 0,
//                   backgroundColor: Colors.transparent,
//                   actions: [
//                     IconButton(
//                       icon: Icon(Icons.logout, color: Colors.black),
//                       onPressed: () {
//                         showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                                   title: Text('Logout'),
//                                   content:
//                                       Text('Are you sure you want to logout?'),
//                                   actions: [
//                                     TextButton(
//                                       child: Text('Yes'),
//                                       onPressed: () async {
//                                         getBox.write('isLoggedIn', false);
//                                         Get.offAll(ScreenSplash());
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: Text('No'),
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                   ],
//                                 ));
//                       },
//                     ),
//                   ],
//                 ),
//                 body: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       StatefulBuilder(builder: (context, setState) {
//                         return Center(
//                           child: SizedBox(
//                             height: 18.h,
//                             width: 18.h,
//                             child: Stack(children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: newImagepath == null
//                                     ? Image.network(
//                                         state.profileData.image!,
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                       )
//                                     : Image.file(
//                                         File(newImagepath!),
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                       ),
//                               ),
//                               InkWell(
//                                 onTap: () async {
//                                   String? imagePath;
//                                   final ImagePicker picker = ImagePicker();
//                                   final XFile? image = await picker.pickImage(
//                                       source: ImageSource.gallery,
//                                       imageQuality: 50);
//                                   if (image != null) {
//                                     CroppedFile? croppedImage =
//                                         await ImageCropper().cropImage(
//                                       sourcePath: image.path,
//                                       compressQuality: 50,
//                                       aspectRatio: const CropAspectRatio(
//                                           ratioX: 1, ratioY: 1),
//                                       uiSettings: [
//                                         AndroidUiSettings(
//                                           toolbarTitle: 'Crop image',
//                                           toolbarColor: kPrimaryColor,
//                                           toolbarWidgetColor: Colors.white,
//                                         )
//                                       ],
//                                     );
//                                     if (croppedImage != null) {
//                                       imagePath = croppedImage.path;
//                                       setState(() {
//                                         isImageChanged = true;
//                                         newImagepath =
//                                             File(croppedImage.path).path;
//                                       });
//                                     } else {
//                                       imagePath = image.path;
//                                       setState(() {
//                                         isImageChanged = true;
//                                         newImagepath = File(image.path).path;
                                        
//                                       });
//                                     }

//                                     setState(() {
//                                       isImageChanged = true;
//                                       newImagepath = imagePath;
//                                     });
//                                     print('imagePath: $imagePath');
//                                   }
//                                 },
//                                 child: Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.blue[500],
//                                     radius: 20,
//                                     child: Icon(
//                                       Icons.edit,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ]),
//                           ),
//                         );
//                       }),
//                       SizedBox(height: 2.h),
//                       Text(
//                         '${state.profileData.firstName!} ${state.profileData.secondName!}',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 2.h),
//                       Container(
//                         // height: 50.h,
//                         padding: EdgeInsets.symmetric(vertical: 20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               // spreadRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(
//                                   left: Dimensions.MARGIN_SIZE_DEFAULT,
//                                   right: Dimensions.MARGIN_SIZE_DEFAULT),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.person,
//                                               color: Colors.blue, size: 20),
//                                           SizedBox(
//                                               width: Dimensions
//                                                   .MARGIN_SIZE_EXTRA_SMALL),
//                                           Text('First Name',
//                                               style: titilliumRegular)
//                                         ],
//                                       ),
//                                       SizedBox(
//                                           height: Dimensions.MARGIN_SIZE_SMALL),
//                                       CustomTextField(
//                                         textInputType: TextInputType.name,
//                                         focusNode: _fNameFocus,
//                                         nextNode: _lNameFocus,
//                                         hintText:
//                                             state.profileData.firstName ?? '',
//                                         controller: _firstNameController,
//                                       ),
//                                     ],
//                                   )),
//                                   SizedBox(width: 15),
//                                   Expanded(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.person,
//                                               color: Colors.blue, size: 20),
//                                           SizedBox(
//                                               width: Dimensions
//                                                   .MARGIN_SIZE_EXTRA_SMALL),
//                                           Text('Last Name',
//                                               style: titilliumRegular)
//                                         ],
//                                       ),
//                                       SizedBox(
//                                           height: Dimensions.MARGIN_SIZE_SMALL),
//                                       CustomTextField(
//                                         textInputType: TextInputType.name,
//                                         focusNode: _lNameFocus,
//                                         nextNode: _emailFocus,
//                                         hintText:
//                                             state.profileData.secondName ?? '',
//                                         controller: _lastNameController,
//                                       ),
//                                     ],
//                                   )),
//                                 ],
//                               ),
//                             ),

//                             // for Email
//                             Container(
//                               margin: EdgeInsets.only(
//                                   top: Dimensions.MARGIN_SIZE_DEFAULT,
//                                   left: Dimensions.MARGIN_SIZE_DEFAULT,
//                                   right: Dimensions.MARGIN_SIZE_DEFAULT),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.alternate_email,
//                                           color: Colors.blue, size: 20),
//                                       SizedBox(
//                                         width:
//                                             Dimensions.MARGIN_SIZE_EXTRA_SMALL,
//                                       ),
//                                       Text('Email', style: titilliumRegular)
//                                     ],
//                                   ),
//                                   SizedBox(
//                                       height: Dimensions.MARGIN_SIZE_SMALL),
//                                   CustomTextField(
//                                     textInputType: TextInputType.emailAddress,
//                                     focusNode: _emailFocus,
//                                     nextNode: _phoneFocus,
//                                     hintText: state.profileData.email ?? '',
//                                     controller: _emailController,
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // for Phone No
//                             Container(
//                               margin: EdgeInsets.only(
//                                   top: Dimensions.MARGIN_SIZE_DEFAULT,
//                                   left: Dimensions.MARGIN_SIZE_DEFAULT,
//                                   right: Dimensions.MARGIN_SIZE_DEFAULT),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.dialpad,
//                                                 color: Colors.blue, size: 20),
//                                             SizedBox(
//                                                 width: Dimensions
//                                                     .MARGIN_SIZE_EXTRA_SMALL),
//                                             Text('Phone No',
//                                                 style: titilliumRegular)
//                                           ],
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 Dimensions.MARGIN_SIZE_SMALL),
//                                         CustomTextField(
//                                           textInputType: TextInputType.number,
//                                           focusNode: _phoneFocus,
//                                           hintText:
//                                               state.profileData.phone ?? "",
//                                           nextNode: _bloodFocus,
//                                           controller: _phoneController,
//                                           isPhoneNumber: true,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(width: 15),
//                                   Expanded(
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.bloodtype,
//                                                 color: Colors.blue, size: 20),
//                                             SizedBox(
//                                                 width: Dimensions
//                                                     .MARGIN_SIZE_EXTRA_SMALL),
//                                             Text('Blood Group',
//                                                 style: titilliumRegular)
//                                           ],
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 Dimensions.MARGIN_SIZE_SMALL),
//                                         CustomTextField(
//                                           textInputType: TextInputType.name,
//                                           focusNode: _bloodFocus,
//                                           hintText:
//                                               state.profileData.blood ?? "",
//                                           nextNode: _ageFocus,
//                                           controller: _bloodController,
//                                           isPhoneNumber: true,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 2.h),
//                             Container(
//                               margin: EdgeInsets.only(
//                                   left: Dimensions.MARGIN_SIZE_DEFAULT,
//                                   right: Dimensions.MARGIN_SIZE_DEFAULT),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.nature_people_outlined,
//                                               color: Colors.blue, size: 20),
//                                           SizedBox(
//                                               width: Dimensions
//                                                   .MARGIN_SIZE_EXTRA_SMALL),
//                                           Text('Age', style: titilliumRegular)
//                                         ],
//                                       ),
//                                       SizedBox(
//                                           height: Dimensions.MARGIN_SIZE_SMALL),
//                                       CustomTextField(
//                                         textInputType: TextInputType.number,
//                                         focusNode: _ageFocus,
//                                         nextNode: _genderFocus,
//                                         hintText:
//                                             state.profileData.age.toString(),
//                                         controller: _ageController,
//                                       ),
//                                     ],
//                                   )),
//                                   const SizedBox(width: 15),
//                                   Expanded(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         children: const [
//                                           Icon(Icons.transgender_rounded,
//                                               color: Colors.blue, size: 20),
//                                           SizedBox(
//                                               width: Dimensions
//                                                   .MARGIN_SIZE_EXTRA_SMALL),
//                                           Text('Gender',
//                                               style: titilliumRegular)
//                                         ],
//                                       ),
//                                       SizedBox(
//                                           height: Dimensions.MARGIN_SIZE_SMALL),
//                                       CustomTextField(
//                                         textInputAction: TextInputAction.done,
//                                         textInputType: TextInputType.name,
//                                         focusNode: _genderFocus,
//                                         nextNode: FocusNode(),
//                                         hintText:
//                                             state.profileData.gender ?? '',
//                                         controller: _genderController,
//                                       ),
//                                     ],
//                                   )),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 2.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) => AlertDialog(
//                                               title: Text('Confirm clear!'),
//                                               actions: [
//                                                 TextButton(
//                                                   child: Text('Yes'),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                     newImagepath = null;
//                                                     context
//                                                         .read<
//                                                             GetprofiledataBloc>()
//                                                         .add(
//                                                             FetchUserProfileDetails());
//                                                   },
//                                                 ),
//                                                 TextButton(
//                                                   child: Text('No'),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                 ),
//                                               ],
//                                             ));
//                                   },
//                                   child: CustomSubmitButton(
//                                     text: 'Clear Changes',
//                                     bgColor: Colors.grey,
//                                     width: 40.w,
//                                     height: 4.h,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) => AlertDialog(
//                                                 title: Text(
//                                                     'Are you sure you want to update your profile?'),
//                                                 actions: [
//                                                   TextButton(
//                                                       child: Text('Yes'),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                         final firstName =
//                                                             _firstNameController
//                                                                 .text;
//                                                         final lastName =
//                                                             _lastNameController
//                                                                 .text;
//                                                         final email =
//                                                             _emailController
//                                                                 .text;
//                                                         final phone =
//                                                             _phoneController
//                                                                 .text;
//                                                         final blood =
//                                                             _bloodController
//                                                                 .text;
//                                                         final age =
//                                                             _ageController.text;
//                                                         final gender =
//                                                             _genderController
//                                                                 .text;
//                                                         final imagePath =
//                                                             !isImageChanged
//                                                                 ? state
//                                                                     .profileData
//                                                                     .image!
//                                                                 : newImagepath!;

//                                                         EditProfileModel
//                                                             editProfileModel =
//                                                             EditProfileModel(
//                                                                 imagePath:
//                                                                     imagePath,
//                                                                 gender: gender,
//                                                                 firstName:
//                                                                     firstName,
//                                                                 secondName:
//                                                                     lastName,
//                                                                 email: email,
//                                                                 phone: phone,
//                                                                 blood: blood,
//                                                                 age: int.parse(
//                                                                     age));
//                                                         context
//                                                             .read<
//                                                                 GetprofiledataBloc>()
//                                                             .add(UpdateAccountEvent(
//                                                                 context:
//                                                                     context,
//                                                                 isImageChanged:
//                                                                     isImageChanged,
//                                                                 editProfileModel:
//                                                                     editProfileModel));
//                                                       }),
//                                                   TextButton(
//                                                       child: Text('No'),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       })
//                                                 ]));
//                                   },
//                                   child: CustomSubmitButton(
//                                     text: 'Update Account',
//                                     bgColor: Colors.blue,
//                                     width: 40.w,
//                                     height: 4.h,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 2.h),
//                       InkWell(
//                         onTap: () {
//                           showDialog(
//                               context: context,
//                               builder: (context) => ChangePasswordAlert());
//                         },
//                         child: CustomSubmitButton(
//                           text: 'Update Password',
//                           bgColor: Colors.redAccent,
//                           width: 40.w,
//                           height: 4.h,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ));
//           }
//           return const Scaffold(
//               body: Center(
//             child: CircularProgressIndicator(),
//           ));
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_health_hospital_app/logic/bloc_get_user_profile/getprofiledata_bloc.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/screen_edit_profile/custom_text_field.dart';
import 'package:one_health_hospital_app/presentation/screen_edit_profile/password_change_alert.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/repositories/user_get_profile/user_get_profile_services.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class ScreenEditProfile extends StatefulWidget {
  ScreenEditProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  final FocusNode _fNameFocus = FocusNode();

  final FocusNode _lNameFocus = FocusNode();

  final FocusNode _ageFocus = FocusNode();

  final FocusNode _genderFocus = FocusNode();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _bloodFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _bloodController = TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  bool isImageChanged = false;

  String? newImagepath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: BlocConsumer<GetprofiledataBloc, GetprofiledataState>(
        listener: (context, state) {
          if (state is ChangeUserPasswordStartedState) {
            showSnackBar(text: state.message, context: context);
          }
          if (state is ChangeUserPasswordSuccessState) {
            showSnackBar(text: state.message, context: context);
          }
          if (state is ChangeUserPasswordErrorState) {
            showSnackBar(text: state.message, context: context);
          }
          if (state is FetchDetailsErrorState) {
            showSnackBar(text: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is FetchProfileDetailsSuccessState) {
            _firstNameController.text = state.profileData.firstName!;
            _lastNameController.text = state.profileData.secondName!;
            _emailController.text = state.profileData.email!;
            _phoneController.text = state.profileData.phone!;
            _ageController.text = state.profileData.age.toString();
            _bloodController.text = state.profileData.blood!;
            _genderController.text = state.profileData.gender!;

            return Scaffold(
                appBar: AppBar(
                  title: Text('Profile', style: TextStyle(color: Colors.black)),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Logout'),
                                  content:
                                      Text('Are you sure you want to logout?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenSigninOrRegister(),
                                                ),
                                                (route) => false);
                                      },
                                    ),
                                    TextButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ));
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StatefulBuilder(builder: (context, setState) {
                        return Center(
                          child: SizedBox(
                            height: 18.h,
                            width: 18.h,
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: newImagepath == null
                                    ? Image.network(
                                        state.profileData.image!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                    : Image.file(
                                        File(newImagepath!),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                              ),
                              InkWell(
                                onTap: () async {
                                  String? imagePath;
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 50);
                                  if (image != null) {
                                    CroppedFile? croppedImage =
                                        await ImageCropper().cropImage(
                                      sourcePath: image.path,
                                      aspectRatio: const CropAspectRatio(
                                          ratioX: 1, ratioY: 1),
                                      uiSettings: [
                                        AndroidUiSettings(
                                          toolbarTitle: 'Crop image',
                                          toolbarColor: kPrimaryColor,
                                          toolbarWidgetColor: Colors.white,
                                        )
                                      ],
                                    );
                                    if (croppedImage != null) {
                                      imagePath = croppedImage.path;
                                      setState(() {
                                        isImageChanged = true;
                                        newImagepath =
                                            File(croppedImage.path).path;
                                      });
                                    } else {
                                      imagePath = image.path;
                                      setState(() {
                                        isImageChanged = true;
                                        newImagepath = File(image.path).path;
                                        ;
                                      });
                                    }

                                    setState(() {
                                      isImageChanged = true;
                                      newImagepath = imagePath;
                                    });
                                    print('imagePath: $imagePath');
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue[500],
                                    radius: 20,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        );
                      }),
                      SizedBox(height: 2.h),
                      Text(
                        '${state.profileData.firstName!} ${state.profileData.secondName!}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        // height: 50.h,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              // spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: Colors.blue, size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text('First Name',
                                              style: titilliumRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.name,
                                        focusNode: _fNameFocus,
                                        nextNode: _lNameFocus,
                                        hintText:
                                            state.profileData.firstName ?? '',
                                        controller: _firstNameController,
                                      ),
                                    ],
                                  )),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: Colors.blue, size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text('Last Name',
                                              style: titilliumRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.name,
                                        focusNode: _lNameFocus,
                                        nextNode: _emailFocus,
                                        hintText:
                                            state.profileData.secondName ?? '',
                                        controller: _lastNameController,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),

                            // for Email
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.alternate_email,
                                          color: Colors.blue, size: 20),
                                      SizedBox(
                                        width:
                                            Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                      ),
                                      Text('Email', style: titilliumRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.emailAddress,
                                    focusNode: _emailFocus,
                                    nextNode: _phoneFocus,
                                    hintText: state.profileData.email ?? '',
                                    controller: _emailController,
                                  ),
                                ],
                              ),
                            ),

                            // for Phone No
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.dialpad,
                                                color: Colors.blue, size: 20),
                                            SizedBox(
                                                width: Dimensions
                                                    .MARGIN_SIZE_EXTRA_SMALL),
                                            Text('Phone No',
                                                style: titilliumRegular)
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.MARGIN_SIZE_SMALL),
                                        CustomTextField(
                                          textInputType: TextInputType.number,
                                          focusNode: _phoneFocus,
                                          hintText:
                                              state.profileData.phone ?? "",
                                          nextNode: _bloodFocus,
                                          controller: _phoneController,
                                          isPhoneNumber: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.bloodtype,
                                                color: Colors.blue, size: 20),
                                            SizedBox(
                                                width: Dimensions
                                                    .MARGIN_SIZE_EXTRA_SMALL),
                                            Text('Blood Group',
                                                style: titilliumRegular)
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.MARGIN_SIZE_SMALL),
                                        CustomTextField(
                                          textInputType: TextInputType.name,
                                          focusNode: _bloodFocus,
                                          hintText:
                                              state.profileData.blood ?? "",
                                          nextNode: _ageFocus,
                                          controller: _bloodController,
                                          isPhoneNumber: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.nature_people_outlined,
                                              color: Colors.blue, size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text('Age', style: titilliumRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.number,
                                        focusNode: _ageFocus,
                                        nextNode: _genderFocus,
                                        hintText:
                                            state.profileData.age.toString(),
                                        controller: _ageController,
                                      ),
                                    ],
                                  )),
                                  const SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.transgender_rounded,
                                              color: Colors.blue, size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text('Gender',
                                              style: titilliumRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputAction: TextInputAction.done,
                                        textInputType: TextInputType.name,
                                        focusNode: _genderFocus,
                                        nextNode: FocusNode(),
                                        hintText:
                                            state.profileData.gender ?? '',
                                        controller: _genderController,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Confirm clear!'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    newImagepath = null;
                                                    context
                                                        .read<
                                                            GetprofiledataBloc>()
                                                        .add(
                                                            FetchUserProfileDetails());
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('No'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ));
                                  },
                                  child: CustomSubmitButton(
                                    text: 'Clear Changes',
                                    bgColor: Colors.grey,
                                    width: 40.w,
                                    height: 4.h,
                                    fontSize: 13,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Are you sure you want to update your profile?'),
                                                actions: [
                                                  TextButton(
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        final firstName =
                                                            _firstNameController
                                                                .text;
                                                        final lastName =
                                                            _lastNameController
                                                                .text;
                                                        final email =
                                                            _emailController
                                                                .text;
                                                        final phone =
                                                            _phoneController
                                                                .text;
                                                        final blood =
                                                            _bloodController
                                                                .text;
                                                        final age =
                                                            _ageController.text;
                                                        final gender =
                                                            _genderController
                                                                .text;
                                                        final imagePath =
                                                            !isImageChanged
                                                                ? state
                                                                    .profileData
                                                                    .image!
                                                                : newImagepath!;

                                                        EditProfileModel
                                                            editProfileModel =
                                                            EditProfileModel(
                                                                imagePath:
                                                                    imagePath,
                                                                gender: gender,
                                                                firstName:
                                                                    firstName,
                                                                secondName:
                                                                    lastName,
                                                                email: email,
                                                                phone: phone,
                                                                blood: blood,
                                                                age: int.parse(
                                                                    age));
                                                        context
                                                            .read<
                                                                GetprofiledataBloc>()
                                                            .add(UpdateAccountEvent(
                                                                context:
                                                                    context,
                                                                isImageChanged:
                                                                    isImageChanged,
                                                                editProfileModel:
                                                                    editProfileModel));
                                                      }),
                                                  TextButton(
                                                      child: Text('No'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      })
                                                ]));
                                  },
                                  child: CustomSubmitButton(
                                    text: 'Update Account',
                                    bgColor: Colors.blue,
                                    width: 40.w,
                                    height: 4.h,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => ChangePasswordAlert());
                        },
                        child: CustomSubmitButton(
                          text: 'Update Password',
                          bgColor: Colors.redAccent,
                          width: 40.w,
                          height: 4.h,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ));
          }
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        },
      ),
    );
  }
}
