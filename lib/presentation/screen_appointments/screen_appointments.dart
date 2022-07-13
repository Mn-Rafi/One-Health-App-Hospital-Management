import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenAppointments extends StatelessWidget {
  const ScreenAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
          body: Center(
        child: Text('Appointments Page'),
      )),
    );
  }
}
