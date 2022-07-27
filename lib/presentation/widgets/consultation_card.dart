import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_health_hospital_app/logic/bloc_home_page/homepage_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_user_appointment/user_appointment_bloc.dart';
import 'package:one_health_hospital_app/logic/models/all_appointments_response_model.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
// import 'package:one_health_hospital_app/logic/models/doctor.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/presentation/screen_bottom_navigatio/screen_bottom_navigation.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_appointment_services/user_appointment_services.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class AppoinmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool? width;

  const AppoinmentCard(
      {Key? key, required this.appointment, this.width = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      // margin: const EdgeInsets.only(left: 18.0, bottom: 5.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          debugPrint('${appointment.active}');
          showDialog(
              context: context,
              builder: (context) {
                return FlipInY(
                  duration: Duration(milliseconds: 500),
                  child: AlertDialog(
                    content: SingleChildScrollView(
                        child: SizedBox(
                            height: 25.h,
                            child: AppoinmentCardDetailed(
                                appointment: appointment))),
                  ),
                );
              });
        },
        child: SizedBox(
          width: !width! ? 250.0 : double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  width: 70.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kGreenColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    appointment.time.toString(),
                    style: theme.textTheme.subtitle1?.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                top: 30.0,
                left: 15.0,
                right: 18.0,
                bottom: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(appointment.status!,
                        style: theme.textTheme.subtitle2!
                            .copyWith(color: Colors.green)),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 2.0,
                            color: kGreenColor,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. : ${appointment.doctor}',
                                  style: theme.textTheme.subtitle2!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(height: 5.0),
                              Text('Reason : ${appointment.reason}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.subtitle2!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(height: 5.0),
                              Text(
                                  'Date : ${appointment.date!.substring(0, 10)}',
                                  style: theme.textTheme.subtitle2!.copyWith(
                                      color: Colors.red, fontSize: 17)),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppoinmentCardDetailed extends StatelessWidget {
  final Appointment appointment;
  final TextEditingController _reasonController = TextEditingController();

  AppoinmentCardDetailed({Key? key, required this.appointment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 250.0,
      // height: 30.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Container(
              width: 70.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGreenColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
              ),
              child: Text(
                appointment.time.toString(),
                style: theme.textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 15.0,
            right: 18.0,
            bottom: 15.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(appointment.status!,
                    style: theme.textTheme.subtitle2!
                        .copyWith(color: Colors.green)),
                const SizedBox(height: 15.0),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 2.0,
                        color: kGreenColor,
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr. : ${appointment.doctor}',
                              style: theme.textTheme.subtitle2!
                                  .copyWith(color: Colors.black)),
                          const SizedBox(height: 5.0),
                          Text('Reason : ${appointment.reason}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.subtitle2!
                                  .copyWith(color: Colors.black)),
                          const SizedBox(height: 5.0),
                          Text('Date : ${appointment.date!.substring(0, 10)}',
                              style: theme.textTheme.subtitle2!
                                  .copyWith(color: Colors.red, fontSize: 17)),
                          const SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                'Are you sure you want to cancel this appointment?'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'Please enter a reason for canceling the appointment'),
                                                  const SizedBox(height: 20.0),
                                                  Card(
                                                    child: CustomTextFormField(
                                                        hintText:
                                                            'Enter a reason...',
                                                        keyBoardType:
                                                            TextInputType.name,
                                                        iconData: Icons
                                                            .text_fields_rounded,
                                                        textController:
                                                            _reasonController),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text('Back'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Confirm Cancel'),
                                                onPressed: () async {
                                                  // Navigator.pop(context);
                                                  // Navigator.pop(context);
                                                  cancelAppointment(
                                                      context: context,
                                                      appointmentId:
                                                          appointment.sId!,
                                                      reason: _reasonController
                                                              .text.isEmpty
                                                          ? 'No reason provided to show'
                                                          : _reasonController
                                                              .text);
                                                },
                                              ),
                                            ],
                                          ));
                                },
                                child: CustomSubmitButton(
                                  text: 'Cancel',
                                  bgColor: Colors.red,
                                  width: 22.w,
                                  fontSize: 14,
                                  height: 3.h,
                                ),
                              ),
                              // Spacer(),
                              // CustomSubmitButton(
                              //   text: 'Reschedule',
                              //   bgColor: Colors.green,
                              //   width: 22.w,
                              //   fontSize: 14,
                              //   height: 3.h,
                              // ),
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future cancelAppointment(
      {required String appointmentId,
      required String reason,
      required BuildContext context}) async {
    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    final List<UserLocalData> userLocalDataList = userLocalData.values.toList();

    final UserAppointmentServices userAppointmentServices =
        UserAppointmentServices();
    showSnackBar(
      text: 'Deleting the appointment',
      context: context,
      duration: 3000,
    );
    // emit(AppointmentDeleteStatus(message: 'Deleting Appointment'));
    try {
      final response = await userAppointmentServices.cancelAppointment(
        reason: reason,
        token: userLocalDataList[0].token,
        id: appointmentId,
      );
      debugPrint('hereeeeeeeeeeeee11111111111');

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        // context.read<HomepageBloc>().add(HomepageEvent());
        debugPrint('hereeeeeeeeeeeee');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ScreenBottomNavigation()),
            (route) => false);
        showSnackBar(
          text: 'Appointment Deleted Succesfully',
          context: context,
          duration: 3000,
        );
        // emit(AppointmentDeleteStatus(message: 'Appointment Deleted'));
      } else {
        throw DioError;
      }
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioError) {
        debugPrint('errrooorrr');
        showSnackBar(
          text: e.response!.data['message'],
          context: context,
          duration: 3000,
        );
      }
    }
  }
}

class AppoinmentCardShimmer extends StatelessWidget {
  const AppoinmentCardShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(left: 18.0, bottom: 5.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          width: 250.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kGreenColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        bottomLeft: Radius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      "10:10 AM",
                      style: theme.textTheme.subtitle1?.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30.0,
                left: 15.0,
                right: 18.0,
                bottom: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Specialist",
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 2.0,
                            color: kGreenColor,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Doctor Name",
                                    style: theme.textTheme.subtitle2!
                                        .copyWith(color: Colors.grey)),
                                const SizedBox(height: 5.0),
                                Text("Reason",
                                    style: theme.textTheme.subtitle2!
                                        .copyWith(color: Colors.grey)),
                                const SizedBox(height: 5.0),
                                Text("Date",
                                    style: theme.textTheme.subtitle2!.copyWith(
                                        color: Colors.grey, fontSize: 17)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
