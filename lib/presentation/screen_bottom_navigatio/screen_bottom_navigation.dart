import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:one_health_hospital_app/logic/bloc_home_page/homepage_bloc.dart';
import 'package:one_health_hospital_app/presentation/screen_ambulance_booking/screen_ambulance_booking.dart';
import 'package:one_health_hospital_app/presentation/screen_blood_bank/screen_blood_bank.dart';
import 'package:one_health_hospital_app/presentation/screen_edit_profile/screen_edit_profile.dart';
import 'package:one_health_hospital_app/presentation/screen_home/screen_home.dart';
import 'package:one_health_hospital_app/repositories/user_get_all_appoinments/user_get_all_appoinments.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';
import 'package:one_health_hospital_app/repositories/user_prescription_services/user_prescription_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenBottomNavigation extends StatefulWidget {
  final int? index;
  const ScreenBottomNavigation({Key? key, this.index}) : super(key: key);

  @override
  State<ScreenBottomNavigation> createState() => _ScreenBottomNavigationState();
}

class _ScreenBottomNavigationState extends State<ScreenBottomNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: BlocProvider(
        create: (context) => HomepageBloc(
            RepositoryProvider.of<GetAllDoctorsServices>(context),
            RepositoryProvider.of<GetAllDepartments>(context),
            RepositoryProvider.of<AppointmentsServices>(context),
            RepositoryProvider.of<UserPrescriptionServices>(context),
            context),
        child: Builder(builder: (context) {
          return BlocBuilder<HomepageBloc, HomepageState>(
            builder: (context, state) {
              return Scaffold(
                body: SizedBox.expand(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    children: <Widget>[
                      ScreenHome(),
                      ScreenAmbulanceBooking(),
                      ScreenBloodBank(
                      ),
                      ScreenEditProfile(),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavyBar(
                  showElevation: false,
                  backgroundColor: Colors.transparent,
                  selectedIndex: _currentIndex,
                  onItemSelected: (index) {
                    setState(() => _currentIndex = index);
                    _pageController.jumpToPage(index);
                  },
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        title: const Text('Home'),
                        icon: const Icon(LineIcons.home)),
                    BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        title: const Text('Emergency'),
                        icon: const Icon(LineIcons.ambulance)),
                    BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        title: const Text('Blood Bank'),
                        icon: const Icon(Icons.bloodtype_outlined)),
                    BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        title: const Text('Profile'),
                        icon: const Icon(LineIcons.userEdit)),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
