import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_health_hospital_app/logic/cubit_splash_screen/splashscreen_cubit.dart';
import 'package:one_health_hospital_app/main.dart';
import 'package:one_health_hospital_app/presentation/screen_bottom_navigatio/screen_bottom_navigation.dart';
import 'package:one_health_hospital_app/presentation/screen_home/screen_home.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:page_transition/page_transition.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashscreenCubit(),
      child: SplashScreenLogic(),
    );
  }
}

class SplashScreenLogic extends StatefulWidget {
  const SplashScreenLogic({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreenLogic> createState() => _SplashScreenLogicState();
}

class _SplashScreenLogicState extends State<SplashScreenLogic> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashscreenCubit, SplashscreenState>(
      listener: (context, state) {
        if (state is SplashscreenEnd) {
          log('Matterr');
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const ScreenSigninOrRegister(),
                  type: PageTransitionType.rightToLeft,
                  alignment: Alignment.center));
        }
        if (state is NavigateToHome) {
          log('No Matter');
          Navigator.pushReplacement(
              context,
              PageTransition(
                child: const ScreenBottomNavigation(),
                type: PageTransitionType.rightToLeft,
                alignment: Alignment.center,
              ));
        }
      },
      child: const ScreenSplashWidget(),
    );
  }
}

class ScreenSplashWidget extends StatelessWidget {
  const ScreenSplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: Center(
          child: ElasticIn(
            duration: const Duration(milliseconds: 3000),
            child: Card(
              elevation: 20,
              shape: const CircleBorder(),
              child: CircleAvatar(
                radius: 25.w,
                backgroundImage: const AssetImage('images/one_health_logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
