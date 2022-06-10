import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';

enum Gender { one, two, three, four, five, six, seven, eight }

class GenderAlertBox extends StatelessWidget {
  GenderAlertBox({Key? key}) : super(key: key);

  static List<String> genders = [
    'Female',
    'Male',
    'Other',
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
              shrinkWrap: true,
              itemCount: genders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(genders[index]),
                  onTap: () {
                    RegisterScreenBody.genderController.text = genders[index];
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ));
  }
}
