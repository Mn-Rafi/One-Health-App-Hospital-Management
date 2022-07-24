import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/logic/map_utils/map_utils.dart';
import 'package:one_health_hospital_app/logic/models/blood_bank_signup_model.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_blood_bank/blood_bank_signup_page_one.dart';
import 'package:one_health_hospital_app/repositories/pdf_generator_services.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ScreenBloodBank extends StatefulWidget {
  ScreenBloodBank({Key? key}) : super(key: key);

  @override
  State<ScreenBloodBank> createState() => _ScreenBloodBankState();
}

class _ScreenBloodBankState extends State<ScreenBloodBank> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('images/donateBlood2.png'),
                Image.asset('images/donateBlood1.png'),
              ],
            ),
            Text("Blood Donors",
                style: theme.textTheme.headline3?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: CustomTextFormField(
                    hintText: 'Search blood group, name, place...',
                    keyBoardType: TextInputType.text,
                    nextAction: TextInputAction.search,
                    iconData: Icons.search,
                    onChanged: (val) {
                      setState(() {});
                    },
                    textController: _searchTextController),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<BloodBankRegisterModel>?>(
                  stream: readDonorsData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    } else if (snapshot.hasData) {
                      final donorDatas = snapshot.data!.where((element) {
                        if (element.name.toLowerCase().contains(
                            _searchTextController.text.toLowerCase())) {
                          return true;
                        }
                        if (element.bloodGroup.toLowerCase().contains(
                            _searchTextController.text.toLowerCase())) {
                          return true;
                        }
                        if (element.location.toLowerCase().contains(
                            _searchTextController.text.toLowerCase())) {
                          return true;
                        }
                        return false;
                      });
                      if (donorDatas.isEmpty) {
                        return Center(child: Text("No Donors found"));
                      }
                      return ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: donorDatas.map(buildUsers).toList(),
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey,
                              height: 3.h,
                              width: 80.w,
                            );
                          },
                        ),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SignUpToBloodBankIntroductionPage(),
                          type: PageTransitionType.leftToRight));
                },
                child: CustomSubmitButton(
                  width: double.infinity,
                  text: 'Register a donor',
                  bgColor: Colors.red,
                  height: 4.5.h,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Colors.blue[800]!,
                highlightColor: Colors.grey[800]!,
                child: OutlinedButton(
                  onPressed: () async {
                    final pdfFile = await PdfApi.showBlooadTypePdf();
                    PdfApi.openFile(pdfFile);
                  },
                  child: Text("Tap to view blood type compatibility",
                      style: theme.textTheme.headline3?.copyWith(
                        fontSize: 18,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUsers(BloodBankRegisterModel donor) => Card(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
        child: ExpansionTile(
          title: Text(
            donor.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(donor.bloodGroup,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red)),
            ],
          ),
          childrenPadding: EdgeInsets.all(5.w),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Text('Age : ${donor.age}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
            Text('Location : \n${donor.location}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
            Text(
                'Contact Numbers : \n${donor.contactNumberOne}, ${donor.contactNumberTwo}',
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
            Text('Last donation : ${donor.lastDateofDonation}',
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
            if (donor.latitude != null && donor.longitude != null)
              Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await MapUtils.openMap(
                        double.parse(donor.latitude!),
                        double.parse(donor.longitude!),
                      );
                    },
                    child: CustomSubmitButton(
                      text: 'Show in map',
                      bgColor: Colors.blue,
                      height: 3.h,
                      width: 30.w,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              )
          ],
          // trailing: Text(donor.age),
        ),
      );

  Stream<List<BloodBankRegisterModel>> readDonorsData() {
    log('hereee');
    return FirebaseFirestore.instance.collection('donors').snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => BloodBankRegisterModel.fromJson(e.data()))
            .toList());
  }
}

List<String> bloodGroups = [
  'A +ve',
  'A -ve',
  'B +ve',
  'B -ve',
  'AB +ve',
  'AB -ve',
  'O +ve',
  'O -ve',
];
