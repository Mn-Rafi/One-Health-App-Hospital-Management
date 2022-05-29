import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/presentation/screen_splash/screen_splash.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkThemeData(context),
        themeMode: ThemeMode.system,
        theme: lightThemeData(context),
        home: const ScreenSplash(),
      );
    });
  }
}
