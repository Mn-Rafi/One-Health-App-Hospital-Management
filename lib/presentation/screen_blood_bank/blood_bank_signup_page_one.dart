import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/screen_blood_bank/blood_bank_sign_up_page_two.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class SignUpToBloodBankIntroductionPage extends StatelessWidget {
  const SignUpToBloodBankIntroductionPage({Key? key}) : super(key: key);

  static Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
  static List<UserLocalData> userLocalDataList = userLocalData.values.toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Blood Donor Sign Up",
            style: theme.textTheme.subtitle2!.copyWith(fontSize: 18),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Hello ${userLocalDataList[0].firstName} ${userLocalDataList[0].secondName}",
                    style: theme.textTheme.headline3
                        ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    'Welcome to One Health Hospital \nBlood Bank Community',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline3?.copyWith(
                      fontSize: 18,
                    )),
              ),
              SizedBox(
                width: double.infinity,
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ScreenBloodBankSignUp(),
                          type: PageTransitionType.leftToRight));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xffE32957),
                      width: 1,
                    ),
                  ),
                  child: CustomSubmitButton(
                    fontColr: Color(0xffE32957),
                    text: 'Tap to sign up now',
                    bgColor: Colors.white,
                    height: 4.h,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 2.h,
              ),
              Container(
                height: 10.h,
                width: double.infinity,
                color: Color(0xffE32957),
                child: const Center(
                    child: Text(
                  'Why you should consider being \nA BLOOD DONOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'BLOOD TRANSFUSION IS NEED FOR',
                style: theme.textTheme.headline3
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 48.png'),
                          Text(
                            'women with complications of pregnancy',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 0.5,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 49.png'),
                          Text(
                              'children with severe anemia as a result of malnutrition',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 0.5,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 50.png'),
                          Text('people with severe trauma following disasters',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 0.5,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 51.png'),
                          Text('complex medical procedures and cancer patients',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 52.png'),
                    const Spacer(),
                    Image.asset('images/Frame 59.png'),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                    'Every two seconds, someone in the United States needs blood, which means more than 38,000 blood donations are needed per day. ',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline3?.copyWith(
                      fontSize: 18,
                    )),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Blood donation is a simple four step process',
                  style: theme.textTheme.headline3
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 64.png'),
                          Text(
                            'Registration, where you sign up and go over eligibility.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 0.5,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 65.png'),
                          Text('Mini-physical, where your health is evaluated.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 0.5,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 66.png'),
                          Text(
                              'The donation, which only takes about eight to ten minutes.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 0.5,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('images/Frame 67.png'),
                          Text(
                              'Refreshments, where you get a snack and drink afterwards.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/Frame 68.png',
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        ' Safe blood saves lives and improves health. It is the most precious gift that anyone can give to another person: the gift of life.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Color(0xffE32957),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign up to be a blood donor today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
