import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:one_health_hospital_app/presentation/screen_edit_profile/screen_edit_profile.dart';
import 'package:one_health_hospital_app/presentation/screen_home/screen_home.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenBottomNavigation extends StatefulWidget {
  const ScreenBottomNavigation({Key? key}) : super(key: key);

  @override
  State<ScreenBottomNavigation> createState() => _ScreenBottomNavigationState();
}

class _ScreenBottomNavigationState extends State<ScreenBottomNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              const Home(),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              ),
              const ScreenEditProfile(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
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
                title: const Text('Appointments'),
                icon: const Icon(LineIcons.calendar)),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                title: const Text('Faculties'),
                icon: const Icon(LineIcons.doctor)),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                title: const Text('Profile'),
                icon: const Icon(LineIcons.userEdit)),
          ],
        ),
      ),
    );
  }
}
