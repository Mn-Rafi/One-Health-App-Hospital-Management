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

  Gender? genderSelect = Gender.one;

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
                    itemCount: GenderAlertBox.genders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile<Gender>(
                          title: Text(GenderAlertBox.genders[index]),
                          value: Gender.values[index],
                          groupValue: genderSelect,
                          onChanged: (Gender? value) {
                            genderSelect = value;
                            RegisterScreenBody.genderController.text =
                                GenderAlertBox.genders[genderSelect!.index];
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
