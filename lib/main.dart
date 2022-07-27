import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:one_health_hospital_app/logic/bloc_get_user_profile/getprofiledata_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_login_api/loginapi_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_user_register/userregister_bloc.dart';
import 'package:one_health_hospital_app/presentation/screen_splash/screen_splash.dart';
import 'package:one_health_hospital_app/repositories/connectivity_services/connectivity_services.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/repositories/user_appointment_services/user_appointment_services.dart';
import 'package:one_health_hospital_app/repositories/user_get_all_appoinments/user_get_all_appoinments.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';
import 'package:one_health_hospital_app/repositories/user_get_profile/user_get_profile_services.dart';
import 'package:one_health_hospital_app/repositories/user_login/user_login_services.dart';
import 'package:one_health_hospital_app/repositories/user_prescription_services/user_prescription_services.dart';
import 'package:one_health_hospital_app/repositories/user_register/user_register_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'channel_id', 'channel_name',
    description: 'channel_description',
    importance: Importance.high,
    showBadge: true,
    enableLights: true,
    enableVibration: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await Hive.initFlutter();
  await GetStorage.init();
  Hive.registerAdapter<UserLocalData>(UserLocalDataAdapter());
  await Hive.openBox<UserLocalData>(userHive);
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
          ),
          RepositoryProvider(
            create: (context) => UserRegisterServices(),
          ),
          RepositoryProvider(
            create: (context) => GetUserProfileServices(),
          ),
          RepositoryProvider(
            create: (context) => GetAllDoctorsServices(),
          ),
          RepositoryProvider(
            create: (context) => GetAllDepartments(),
          ),
          RepositoryProvider(
            create: (context) => AppointmentsServices(),
          ),
          RepositoryProvider(
            create: (context) => UserAppointmentServices(),
          ),
          RepositoryProvider(
            create: (context) => UserPrescriptionServices(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => LoginapiBloc(
                    RepositoryProvider.of<ConnectivityServices>(context),
                    RepositoryProvider.of<UserLoginServices>(context))),
            BlocProvider(
                create: (context) => UserregisterBloc(
                      RepositoryProvider.of<UserRegisterServices>(context),
                    )),
            BlocProvider(
              create: (context) => GetprofiledataBloc(
                RepositoryProvider.of<GetUserProfileServices>(context),
              ),
            )
          ],
          child: GetMaterialApp(
            title: 'One Health Hospital',
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
