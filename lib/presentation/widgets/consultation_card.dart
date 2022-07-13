import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/logic/models/all_appointments_response_model.dart';
// import 'package:one_health_hospital_app/logic/models/doctor.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:shimmer/shimmer.dart';

class AppoinmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppoinmentCard({Key? key, required this.appointment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(left: 18.0, bottom: 5.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: (){},
        child: SizedBox(
          width: 250.0,
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
                              Text('Date : ${appointment.date}',
                                  style: theme.textTheme.subtitle2!
                                      .copyWith(color: Colors.red, fontSize: 17)),
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
