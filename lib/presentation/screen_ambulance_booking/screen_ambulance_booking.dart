import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_health_hospital_app/logic/bloc_home_page/homepage_bloc.dart';
import 'package:one_health_hospital_app/logic/map_utils/map_utils.dart';
import 'package:one_health_hospital_app/logic/models/blood_bank_signup_model.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class ScreenAmbulanceBooking extends StatefulWidget {
  ScreenAmbulanceBooking({Key? key}) : super(key: key);

  @override
  State<ScreenAmbulanceBooking> createState() => _ScreenAmbulanceBookingState();
}

class _ScreenAmbulanceBookingState extends State<ScreenAmbulanceBooking>
    with TextFieldValidator {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _altPhoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
  static List<UserLocalData> userLocalDataList = userLocalData.values.toList();

  bool isSearching = false;
  bool checkingDetails = false;
  String? bookingId;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    print(place.toJson().toString());
    _addressController.text =
        '${place.subAdministrativeArea}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isConfirmed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text =
        '${userLocalDataList[0].firstName} ${userLocalDataList[0].secondName}';
    _phoneController.text = userLocalDataList[0].phone.toString().substring(3);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Book Ambulance",
            style: theme.textTheme.subtitle2!.copyWith(fontSize: 16),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
        ),
        body: BlocConsumer<HomepageBloc, HomepageState>(
          listener: (context, state) {
            if (state is HomePageFetchDoctorsSuccessState) {
              log('nettttttttttttt');
              // Navigator.pop(context);
              _nameController.text = state.userName;
              log(_nameController.text);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Enter the details below",
                          style: theme.textTheme.headline3?.copyWith(
                            fontSize: 18,
                          )),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              'https://img.freepik.com/premium-vector/ambulance-icon_28461-140.jpg?w=2000')),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                          validator: (val) {
                            return isNameValid(val, 'Patient Name');
                          },
                          hintText: 'Patient Name',
                          keyBoardType: TextInputType.name,
                          iconData: Icons.person,
                          textController: _patientNameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                          validator: (val) {
                            return isNameValid(val, 'Name');
                          },
                          hintText: 'Name',
                          keyBoardType: TextInputType.name,
                          iconData: Icons.person,
                          textController: _nameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                          validator: (val) {
                            return isMobileValid(
                              val,
                            );
                          },
                          hintText: 'Phone Number',
                          keyBoardType: TextInputType.number,
                          iconData: Icons.call,
                          textController: _phoneController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                          validator: (val) {
                            return isMobileValid(
                              val,
                            );
                          },
                          hintText: 'Alternate Phone Number',
                          keyBoardType: TextInputType.number,
                          iconData: Icons.call,
                          textController: _altPhoneController),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8.0,
                      ),
                      child: CustomTextFormField(
                          // maxLines: 3,
                          // enabled: false,
                          validator: (val) {
                            return isValid(value: val, nameOFFiled: 'Address');
                          },
                          hintText: 'Address',
                          keyBoardType: TextInputType.name,
                          iconData: Icons.home_work,
                          textController: _addressController),
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          setState(() {
                            isSearching = true;
                          });
                          Position position = await _determinePosition();

                          print(position.toString());
                          GetAddressFromLatLong(position);
                          setState(() {
                            isSearching = false;
                          });
                          // _addressController.text = position.latitude.toString();
                        },
                        icon: !isSearching
                            ? Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue[900],
                              )
                            : SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.blue[900],
                                  strokeWidth: 1,
                                )),
                        label: Text(
                          'tap to get current location',
                          style: TextStyle(color: Colors.blue[900]),
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CustomTextFormField(
                    //       hintText: 'Time Slot',
                    //       keyBoardType: TextInputType.name,
                    //       iconData: Icons.timer,
                    //       textController: _addressController),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CustomTextFormField(
                    //       hintText: 'Date',
                    //       keyBoardType: TextInputType.name,
                    //       iconData: Icons.timer,
                    //       textController: _addressController),
                    // ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            checkingDetails = true;
                            isConfirmed = false;
                          });
                          bookingId =
                              DateTime.now().toString() + _phoneController.text;
                          bookAmbulance(
                              AmbulanceBookingResponse(
                                isRequested: true,
                                address: _addressController.text,
                                dateTime: DateTime.now().toString(),
                                id: bookingId!,
                              ),
                              context);
                          await Get.defaultDialog(
                            title: 'Booking Confirmation!',
                            middleText:
                                'You will get the details once the ambulance is confirmed\nPlease don\'t go back, stay in this page',
                            content: StreamBuilder<
                                    List<AmbulanceBookingResponse>?>(
                                stream: readDonorsData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final AmbulanceBookingResponse
                                        bookingResponse = snapshot.data!
                                            .where((element) =>
                                                element.id == bookingId)
                                            .first;
                                    if (bookingResponse.isrejected != null) {
                                      final bool success =
                                          bookingResponse.isrejected!;
                                      if (success) {
                                        isConfirmed = false;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'All our ambulance are busy. \nSorry for the inconvenience',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      } else {
                                        Get.back();
                                        isConfirmed = true;
                                      }
                                    }
                                    return Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'You will get the details once the ambulance is confirmed\nPlease don\'t go back, stay in this page',
                                            style: TextStyle(fontSize: 15.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    ));
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                          );
                          if (isConfirmed) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Booking Confirmed'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                          'Expected arrival time : ${DateTime.now().add(Duration(minutes: 10)).toString().substring(11, 16)}'),
                                      Text('Ambulance number : KL14 AD2000'),
                                      Text('Ambulance driver contact : '),
                                      TextButton.icon(
                                        onPressed: () {
                                          Clipboard.setData(new ClipboardData(
                                              text: '954445539'));
                                          showSnackBar(
                                              text:
                                                  'Driver\'s number copied to clipboard',
                                              context: context);
                                        },
                                        icon: Icon(
                                          Icons.copy,
                                          color: Colors.blue,
                                        ),
                                        label: Text(
                                          '+91954******3',
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      setState(() {
                                        checkingDetails = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                          setState(() {
                            checkingDetails = false;
                          });
                        }
                      },
                      child: !checkingDetails
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomSubmitButton(
                                text: 'Book Now',
                                bgColor: Colors.red,
                                height: 5.h,
                              ),
                            )
                          : CustomLoadingSubmitButton(
                              text: 'Book', bgColor: Colors.red),
                    ),
                    // StreamBuilder<List<AmbulanceBookingResponse>?>(
                    //     stream: readDonorsData(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData) {
                    //         return ListView.builder(
                    //           shrinkWrap: true,
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: snapshot.data!.length,
                    //           itemBuilder: (context, index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Card(
                    //                 child: ListTile(
                    //                   title: Text(
                    //                     snapshot.data![index].isRequested
                    //                         .toString(),
                    //                     style: TextStyle(
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                   subtitle: Text(
                    //                     snapshot.data![index].address,
                    //                     style: TextStyle(
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                   trailing: Text(
                    //                     snapshot.data![index].dateTime
                    //                         .toString()
                    //                         .substring(11, 16),
                    //                     style: TextStyle(
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         );
                    //       } else {
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       }
                    //     }),
                    SizedBox(
                      height: 2.h,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Stream<List<AmbulanceBookingResponse>> readDonorsData() {
    log('hereee');
    return FirebaseFirestore.instance
        .collection('ambulance')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => AmbulanceBookingResponse.fromJson(e.data()))
          .toList();
    });
  }

  bookAmbulance(AmbulanceBookingResponse ambulanceBookingResponse,
      BuildContext context) async {
    final donor = FirebaseFirestore.instance
        .collection('ambulance')
        .doc(ambulanceBookingResponse.id);
    await donor.set(ambulanceBookingResponse.toJson()).then((value) {
      // Get.snackbar(
      //   'Success',
      //   'Registered Successfully',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
      // Navigator.pop(context);
      // Navigator.pop(context);
      return null;
    });
  }
}
