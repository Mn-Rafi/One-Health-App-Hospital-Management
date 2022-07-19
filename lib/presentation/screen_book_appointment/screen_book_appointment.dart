import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:one_health_hospital_app/logic/bloc_user_appointment/user_appointment_bloc.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_bottom_navigatio/screen_bottom_navigation.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_appointment_services/user_appointment_services.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenBookAppointment extends StatefulWidget {
  final DoctorResponseModel doctor;
  ScreenBookAppointment({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  State<ScreenBookAppointment> createState() => _ScreenBookAppointmentState();
}

class _ScreenBookAppointmentState extends State<ScreenBookAppointment>
    with TextFieldValidator {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _reasonController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _doctorController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _feeController = TextEditingController();

  final date = DateTime.now().toString().substring(0, 10).toString();
  String? authToken;
  final _razorpay = Razorpay();
  UserLocalData? userData;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print('Successssssssssssssss');
    print(response.paymentId.toString());
    print('Successssssssssssssss');
    Dio dio = Dio();

    try {
      isLoading = true;
      final Response appointmentResponse =
          await dio.post('https://onehealthhospital.online/api/appointment/',
              data: {
                "userId": userData!.id,
                "doctorId": widget.doctor.doctor!.sId,
                "paymentId": response.paymentId,
                "user": _nameController.text,
                "doctor": widget.doctor.doctor!.name,
                "status": "Scheduled",
                "date": _dateController.text,
                "time": _timeController.text,
                "fee": int.parse(widget.doctor.doctor!.fee.toString()),
                "active": true,
                "age": int.parse(_ageController.text),
                "gender": _genderController.text,
                "phone": _phoneController.text,
                "reason": _reasonController.text
              },
              options: Options(headers: {'auth-token': authToken!}));
      log(appointmentResponse.toString());
      if (appointmentResponse.statusCode == 201) {
        isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ScreenBottomNavigation(),
            ),
            (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _dateController.text = date;
    _doctorController.text = 'Dr. ${widget.doctor.doctor!.name!}';
    _feeController.text = '₹${widget.doctor.doctor!.fee!}';
    print(DateTime.now());
    return BlocProvider(
      create: (context) => UserAppointmentBloc(
        RepositoryProvider.of<UserAppointmentServices>(context),
      )..add(UserAppointmentByDate(
          dateTime: DateTime.now(),
          doctorId: widget.doctor.doctor!.sId!,
          context: context,
        )),
      child: Container(
        decoration: kboxdecoration,
        child: Scaffold(
          body: BlocConsumer<UserAppointmentBloc, UserAppointmentState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is UserAppointmentByDateState) {
                userData = state.userLocalDataList[0];
                authToken = state.userLocalDataList[0].token;
                // return Center(
                //   child: Container(
                //     child: Text(state
                //         .appointmentSlotByDateResponse.doctorTiming.days
                //         .toString()),
                //   ),
                // );
                _nameController.text =
                    '${state.userLocalDataList[0].firstName} ${state.userLocalDataList[0].secondName}';
                _ageController.text = state.userLocalDataList[0].age.toString();
                _genderController.text = state.userLocalDataList[0].gender;
                _phoneController.text =
                    state.userLocalDataList[0].phone.toString().substring(3);
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "Book Appointment",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomTextFormField(
                                validator: (val) =>
                                    isNameValid(val, 'patient name'),
                                hintText: 'Patient Name',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.person,
                                textController: _nameController),
                            SizedBox(height: 2.h),
                            CustomTextFormField(
                                validator: (val) => isAgeValid(val),
                                hintText: 'Age',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.nature_people_outlined,
                                textController: _ageController),
                            SizedBox(height: 2.h),
                            CustomTextFormField(
                                validator: (val) =>
                                    isValid(nameOFFiled: 'gender', value: val),
                                hintText: 'Gender',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.transgender,
                                textController: _genderController),
                            SizedBox(height: 2.h),
                            CustomTextFormField(
                                validator: (val) => isMobileValid(val),
                                hintText: 'Phone Number',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.phone,
                                textController: _phoneController),
                            SizedBox(height: 2.h),
                            CustomTextFormField(
                                // maxLines: 2,
                                validator: (val) =>
                                    isValid(nameOFFiled: 'reason', value: val),
                                hintText: 'Reason for appointment...',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.note_add_sharp,
                                textController: _reasonController),
                            SizedBox(height: 2.h),
                            CustomTextFormField(
                                // maxLines: 2,
                                enabled: false,
                                hintText: 'Appointment to',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.local_hospital_sharp,
                                textController: _doctorController),
                            SizedBox(height: 2.h),
                            CustomTextFormField(
                                // maxLines: 2,
                                enabled: false,
                                hintText: 'Fee amount',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.money,
                                textController: _feeController),
                            SizedBox(height: 2.h),
                            InkWell(
                              onTap: () async {
                                _dateController.text = await pickdate(
                                    context, widget.doctor.doctor!.days!);
                                context
                                    .read<UserAppointmentBloc>()
                                    .add(UserAppointmentByDate(
                                      dateTime:
                                          DateTime.parse(_dateController.text),
                                      doctorId: widget.doctor.doctor!.sId!,
                                      context: context,
                                    ));
                              },
                              child: CustomTextFormField(
                                validator: (val) =>
                                    isValid(nameOFFiled: 'date', value: val),
                                // maxLines: 2,
                                enabled: false,
                                hintText: 'Select Date',
                                keyBoardType: TextInputType.name,
                                iconData: Icons.date_range,
                                textController: _dateController,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            if (_dateController.text != '')
                              InkWell(
                                onTap: () {
                                  final List<String> timeList = availableSlots(
                                      timeArray: state
                                          .appointmentSlotByDateResponse
                                          .timeArray,
                                      endTime: state
                                          .appointmentSlotByDateResponse
                                          .doctorTiming
                                          .endTime,
                                      startTime: state
                                          .appointmentSlotByDateResponse
                                          .doctorTiming
                                          .startTime);
                                  // await Future.delayed(Duration(seconds: 1));
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Choose an available time slot',
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          content: SizedBox(
                                            width: double.maxFinite,
                                            child: ListView.builder(
                                              // physics: const NeverScrollableScrollPhysics(),
                                              itemCount: timeList.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(timeList[index]),
                                                  onTap: () {
                                                    _timeController.text =
                                                        timeList[index];
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              },
                                            ),
                                          )));
                                },
                                child: CustomTextFormField(
                                  validator: (val) =>
                                      isValid(nameOFFiled: 'time', value: val),
                                  // maxLines: 2,
                                  enabled: false,
                                  hintText: 'Select Time',
                                  keyBoardType: TextInputType.name,
                                  iconData: Icons.access_time,
                                  textController: _timeController,
                                ),
                              ),
                            if (_dateController.text != '')
                              SizedBox(height: 2.h),
                            if (!isLoading)
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    final options = {
                                      'key': 'rzp_test_NibFswO46i1XDM',
                                      'amount': 100 * 100,
                                      'name': 'Acme Corp.',
                                      'description': 'Fine T-Shirt',
                                      'prefill': {
                                        'contact':
                                            state.userLocalDataList[0].phone,
                                        'email':
                                            state.userLocalDataList[0].email,
                                      }
                                    };
                                    _razorpay.open(options);
                                  } else {
                                    if (_dateController.text.isEmpty) {
                                      showSnackBar(
                                          text: 'Please select date',
                                          context: context);
                                    } else if (_timeController.text.isEmpty) {
                                      showSnackBar(
                                          text: 'Please select time',
                                          context: context);
                                    }
                                  }
                                },
                                child: CustomSubmitButton(
                                    text: 'Book Appointment',
                                    bgColor: Colors.redAccent),
                              )
                            else
                              CustomLoadingSubmitButton(
                                  text: 'Book Appointment',
                                  bgColor: Colors.redAccent)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  DateTime initialDate = DateTime.now();
  DateTime intitalDate(List<int> days) {
    if (days.contains(initialDate.weekday)) {
      initialDate = initialDate.add(const Duration(days: 1));
      if (days.contains(initialDate.weekday)) {
        return intitalDate(days);
      }
    }
    return initialDate;
  }

  // Future picktime(BuildContext context, )
  Future pickdate(BuildContext context, List<int> days) async {
    // final initialDate = DateTime.parse(_dateController.text);

    final _date = await showDatePicker(
      selectableDayPredicate: (DateTime val) {
        if (days.contains(val.weekday)) {
          return true;
        } else {
          return false;
        }
      },
      context: context,
      initialDate: _dateController.text.isEmpty
          ? DateTime.now()
          : DateTime.parse(_dateController.text),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (_date != null) {
      return _date.toString().substring(0, 10);
    } else {
      return _dateController.text;
    }
  }

  List<String> timeSlots = [
    '08:00 AM',
    '08:30 AM',
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
    '06:00 PM',
    '06:30 PM',
    '07:00 PM',
    '07:30 PM',
    '08:00 PM',
    '08:30 PM',
    '09:00 PM',
    '09:30 PM',
    '10:00 PM',
    '10:30 PM',
    '11:00 PM',
    '11:30 PM',
  ];

  List<String> availableSlots(
      {required String startTime,
      required String endTime,
      required List<String> timeArray}) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);

    final parsedTime = DateTime.parse(
        '${_dateController.text} ${time12to24Format(startTime)}:00');

    print(_dateController.text);
    print('____________');
    print(now.toString().substring(0, 10));
    // if (_dateController.text == now.toString().substring(0, 10)) {
    //   if (now.hour >= parsedTime.hour) {
    //     if (formattedTime[2] != ':') {
    //       formattedTime = '0$formattedTime';
    //     }
    //     startTime = formattedTime;
    //   } else {
    //     print('nothing to change in 1 $startTime');
    //   }
    // }
    List<String> slots = timeSlots;
    int? startingPoint;
    int? endingPoint;
    for (int i = 0; i < slots.length; i++) {
      print('^^^^^^^^^^^^^^^^^');
      print(slots[i].substring(0, 2) + startTime.substring(0, 2));
      print('^^^^^^^^^^^^^^^^^');
      if (slots[i] == startTime) {
        print('starting point $i');
        startingPoint = i;
      }
      if (slots[i] == endTime) {
        print('ending point $i');
        endingPoint = i;
      }
    }

    print('slots : ' + slots.toString());

    print('nothing to change in 8 $startTime');
    print('Starting : ${startingPoint!}Ending : ${endingPoint!}');
    List<String> returnList = slots.sublist(startingPoint, endingPoint + 1);
    print('Return List $returnList');
    for (int i = 0; i < returnList.length; i++) {
      print('nothing to change in 9 $startTime');
      if (timeArray.contains(returnList[i])) {
        print('nothing to change in 10 $startTime');
        returnList.removeAt(i);
        i--;
      }
    }

    print('nothing to change in 11 $startTime');
    return returnList;
  }

  String time12to24Format(String time) {
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String meridium = time.split(":").last.split(" ").last.toLowerCase();
    if (meridium == "pm") {
      if (h != 12) {
        h = h + 12;
      }
    }
    if (meridium == "am") {
      if (h == 12) {
        h = 00;
      }
    }
    String newTime = "${h == 0 ? "00" : h}:${m == 0 ? "00" : m}";
    if (newTime[2] != ':') {
      newTime = '0$newTime';
    }
    return newTime;
  }
}