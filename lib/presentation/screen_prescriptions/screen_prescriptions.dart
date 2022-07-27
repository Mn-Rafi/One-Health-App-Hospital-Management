import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:one_health_hospital_app/logic/models/prescriptions_response_model.dart';
import 'package:one_health_hospital_app/presentation/widgets/precription_card.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenPrescriptions extends StatelessWidget {
  final List<Prescription>? prescriptionList;
  const ScreenPrescriptions({
    Key? key,
    required this.prescriptionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: kboxdecoration,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Prescriptions'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            prescriptionList!.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 20.h,
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: PrescriptionCard(
                                          width: true,
                                          prescription:
                                              prescriptionList![index],
                                        ))));
                          },
                          itemCount: prescriptionList!.length),
                    ],
                  )
                : Center(
                    child: Text(
                    'No prescriptions Found',
                    style: theme.textTheme.headline6,
                  )),
          ])),
        ));
  }
}
