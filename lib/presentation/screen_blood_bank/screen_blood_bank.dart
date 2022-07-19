import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/presentation/screen_blood_bank/blood_bank_signup_page_one.dart';
import 'package:one_health_hospital_app/repositories/pdf_generator_services.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ScreenBloodBank extends StatelessWidget {
  const ScreenBloodBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('images/donateBlood2.png'),
                Image.asset('images/donateBlood1.png'),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SignUpToBloodBankIntroductionPage(),
                          type: PageTransitionType.leftToRight));
                },
                child: Text("Sign Up to become a blood donor today",
                    style: theme.textTheme.headline3?.copyWith(
                      fontSize: 18,
                    )),
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
            Text("Blood Donors",
                style: theme.textTheme.headline3?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            SizedBox(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bloodGroups.length,
                  shrinkWrap: true,
                  itemBuilder: (context, ind) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ExpansionTile(
                          title: Text(
                            bloodGroups[ind],
                            style: theme.textTheme.headline3?.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ExpansionTile(
                                title: Text(
                                  index.toString(),
                                ),
                                children: [
                                  Text("Blood Group : ",
                                      style:
                                          theme.textTheme.headline3?.copyWith(
                                        fontSize: 18,
                                      )),
                                  Text("Age : ",
                                      style:
                                          theme.textTheme.headline3?.copyWith(
                                        fontSize: 18,
                                      )),
                                  Text("Location : ",
                                      style:
                                          theme.textTheme.headline3?.copyWith(
                                        fontSize: 18,
                                      )),
                                  Text("Last Date of Donation",
                                      style:
                                          theme.textTheme.headline3?.copyWith(
                                        fontSize: 18,
                                      )),
                                  Text("Contact Numbers : ",
                                      style:
                                          theme.textTheme.headline3?.copyWith(
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ]),
                    );
                  }),
            )
          ],
        )),
      ),
    );
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
