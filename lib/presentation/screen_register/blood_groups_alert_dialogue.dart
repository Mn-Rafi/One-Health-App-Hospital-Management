import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';

enum BloodGroup { one, two, three, four, five, six, seven, eight }

class BloodGroupAlertBox extends StatelessWidget {
  BloodGroupAlertBox({Key? key}) : super(key: key);

  static List<String> bloodGroups = [
    'A +ve',
    'B +ve',
    'O +ve',
    'AB +ve',
    'A -ve',
    'B -ve',
    'O -ve',
    'AB -ve'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Choose Your Blood Group'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: bloodGroups.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bloodGroups[index]),
                  onTap: () {
                    RegisterScreenBody.bloodGroupController.text = bloodGroups[index];
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ));
  }
}
