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

  BloodGroup? bloodGroupSelect = BloodGroup.one;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Your Blood Group'),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: BloodGroupAlertBox.bloodGroups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile<BloodGroup>(
                          title: Text(BloodGroupAlertBox.bloodGroups[index]),
                          value: BloodGroup.values[index],
                          groupValue: bloodGroupSelect,
                          onChanged: (BloodGroup? value) {
                            bloodGroupSelect = value;

                            Screenregister.bloodGroupController.text =
                                BloodGroupAlertBox
                                    .bloodGroups[bloodGroupSelect!.index];
                            Navigator.pop(context);
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
