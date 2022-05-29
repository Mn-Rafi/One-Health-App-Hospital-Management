import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/cubit_splash_screen/splashscreen_cubit.dart';
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
      child: BlocListener<SplashscreenCubit, SplashscreenState>(
        listener: (context, state) {
          if (state is SplashscreenEnd) {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const ScreenSigninOrRegister(),
                    type: PageTransitionType.rightToLeft,
                    alignment: Alignment.center));
          }
        },
        child: const ScreenSplashWidget(),
      ),
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
