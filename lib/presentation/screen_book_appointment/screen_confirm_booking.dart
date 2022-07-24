import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/screen_book_appointment/screen_book_appointment.dart';

import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class ConfirmAppointment extends StatefulWidget {
  final String patientName;
  final String age;
  final String gender;
  final String phoneNumber;
  final String doctorName;
  final String reason;
  final String fee;
  final String date;
  final String time;
  ConfirmAppointment({
    Key? key,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.doctorName,
    required this.reason,
    required this.fee,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<ConfirmAppointment> createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secondColumn = [
      widget.patientName,
      widget.age,
      widget.gender,
      widget.phoneNumber,
      widget.doctorName,
      widget.reason,
      widget.fee,
      widget.date,
      widget.time
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Confirm Appointment'),
            foregroundColor: Colors.black,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Column(
          children: [
            SizedBox(
              height: 2.h,
              width: double.infinity,
            ),
            Text(
              "Verify Details",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontSize: 18, decoration: TextDecoration.underline),
            ),
            SizedBox(
              height: 2.h,
            ),
            Image.asset(
              'images/confirmImage.png',
              width: 50.w,
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        // blurRadius: 2.0,
                        // spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Table(
                    columnWidths: const {
                      0: FractionColumnWidth(0.35),
                      1: FractionColumnWidth(0.65)
                    },
                    // border: TableBorder.all(color: Colors.black, ),
                    children: List<TableRow>.generate(
                        firstColumn.length,
                        (index) => TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  firstColumn[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    secondColumn[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                            ]))),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, true);
                // Get.to(ScreenBookAppointment(doctor: null,));
              },
              child: CustomSubmitButton(
                  text: 'Continue to payment',
                  bgColor: Colors.red,
                  height: 5.h,
                  fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }

  List<String> firstColumn = [
    'Patient',
    'Age',
    'Gender',
    'Phone No',
    'Doctor',
    'Reason',
    'Fee Amount',
    'Date',
    'Time'
  ];

  List<String> secondColumn = [];
}
