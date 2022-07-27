import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/screen_book_appointment/screen_book_appointment.dart';
import 'package:sizer/sizer.dart';

import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenDoctorProfile extends StatelessWidget {
  final DoctorResponseModel doctor;
  const ScreenDoctorProfile({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          Hero(
            tag: 'doctor_profile_${doctor.doctor!.name}',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(doctor.doctor!.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.5),
              //     blurRadius: 10.0,
              //     // spreadRadius: 0.0,
              //   ),
              // ],
              // gradient: const LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Colors.white,
              //     Color(0xffE5e6e4),
              //   ],
              // ),
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${doctor.doctor!.name}',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontSize: 18.sp),
                      ),
                      Text(
                        doctor.doctor!.qualification!,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 15.sp, color: Colors.deepPurple),
                      ),
                      Text(
                        '(${doctor.doctor!.department})',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontSize: 15.sp),
                      ),
                      Text(
                        'Expertised in ${doctor.doctor!.expertise}',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontSize: 12.sp),
                      ),
                      SizedBox(
                        width: 80.w,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text('Working Days',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontSize: 20.sp, color: Colors.black)),
          SizedBox(
            height: 6.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.w),
                    color: Colors.white,
                  ),
                  child: Text(
                    checkDays(doctor.doctor!.days!)[index],
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontSize: 13.sp, color: Colors.black),
                  ),
                ),
              ),
              separatorBuilder: (_, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                width: 1,
                height: 3.h,
                color: Colors.grey,
              ),
              itemCount: doctor.doctor!.days!.length,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text('Timing',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontSize: 20.sp, color: Colors.black)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.w),
              color: Colors.white,
            ),
            child: Text(
              '${doctor.doctor!.startTime!} - ${doctor.doctor!.endTime!}',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontSize: 13.sp, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fee',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontSize: 20.sp, color: Colors.black)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.w),
                  color: Colors.white,
                ),
                child: Text(
                  '₹${doctor.doctor!.fee}',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontSize: 13.sp, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          InkWell(
            onTap: () {
              // log(DateTime.now().toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenBookAppointment(doctor: doctor),
                  ));
            },
            child: CustomSubmitButton(
              text: 'Book an Appointment',
              bgColor: Colors.red,
              height: 5.h,
              fontSize: 18,
            ),
          )
        ])),
      ),
    );
  }
}

List<String> checkDays(List<int> days) {
  List<String> daysString = [];
  for (int i = 0; i < days.length; i++) {
    if (days[i] == 1) {
      daysString.add('Mon');
    }
    if (days[i] == 2) {
      daysString.add('Tue');
    }
    if (days[i] == 3) {
      daysString.add('Wed');
    }
    if (days[i] == 4) {
      daysString.add('Thu');
    }
    if (days[i] == 5) {
      daysString.add('Fri');
    }
    if (days[i] == 6) {
      daysString.add('Sat');
    }
    if (days[i] == 7) {
      daysString.add('Sun');
    }
  }
  return daysString;
}
