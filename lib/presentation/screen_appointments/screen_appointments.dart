import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:one_health_hospital_app/logic/models/all_appointments_response_model.dart';
import 'package:one_health_hospital_app/presentation/widgets/consultation_card.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class ScreenAppointments extends StatelessWidget {
  final List<Appointment>? appointment;
  ScreenAppointments({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  List<Appointment?> scheduledList = [];
  List<Appointment?> completedList = [];
  List<Appointment?> cancelledList = [];

  @override
  Widget build(BuildContext context) {
    appointment!.map((e) {
      log(e.status.toString());
      if (e.status == 'Scheduled') {
        scheduledList.add(e);
        return e;
      } else if (e.status == 'Complete') {
        completedList.add(e);
        return e;
      } else if (e.status == 'Cancelled' || e.status == 'Canceled') {
        cancelledList.add(e);
        return e;
      }
    }).toList();

    log(scheduledList.length.toString());
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: SizedBox(
          // width: 80.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Scheduled Appoinments",
                          style: theme.textTheme.headline3?.copyWith(
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 20.h,
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: AppoinmentCard(
                                width: true,
                                appointment: scheduledList[index]!),
                          )));
                    },
                    itemCount: scheduledList.length),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Completed Appoinments",
                          style: theme.textTheme.headline3?.copyWith(
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 20.h,
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: AppoinmentCard(
                                width: true,
                                appointment: completedList[index]!),
                          )));
                    },
                    itemCount: completedList.length),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cancelled Appoinments",
                          style: theme.textTheme.headline3?.copyWith(
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 20.h,
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: AppoinmentCard(
                                width: true,
                                appointment: cancelledList[index]!),
                          )));
                    },
                    itemCount: cancelledList.length),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
