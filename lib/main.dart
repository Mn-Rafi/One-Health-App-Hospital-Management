import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_login_api/loginapi_bloc.dart';
import 'package:one_health_hospital_app/presentation/screen_splash/screen_splash.dart';
import 'package:one_health_hospital_app/repositories/connectivity_services/connectivity_services.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_services.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

void preImageCache(BuildContext context) {
  for (int i = 0; i < imageList.length; i++) {
    precacheImage(AssetImage(imageList[i]), context);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    preImageCache(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ConnectivityServices(),
          ),
          RepositoryProvider(
            create: (context) => UserLoginServices(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => LoginapiBloc(
                      RepositoryProvider.of<ConnectivityServices>(context),
                      RepositoryProvider.of<UserLoginServices>(context),
                    ))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: darkThemeData(context),
            themeMode: ThemeMode.system,
            theme: lightThemeData(context),
            home: const ScreenSplash(),
          ),
        ),
      );
    });
  }
}
