import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/presentation/models/doctor.dart';
import 'package:one_health_hospital_app/presentation/widgets/consultation_card.dart';
import 'package:one_health_hospital_app/presentation/widgets/doctor_card.dart';
import 'package:one_health_hospital_app/presentation/widgets/specialist_card.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/themedata.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
    final List<UserLocalData> userLocalDataList = userLocalData.values.toList();
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: ListTile(
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: NetworkImage(userLocalDataList[0].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(userLocalDataList[0].firstName,
                    style: theme.textTheme.headline3?.copyWith(fontSize: 18)),
                subtitle: Text(
                  "Find your suitable doctor here",
                  style: theme.textTheme.subtitle2,
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: theme.cardColor,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: kPrimaryLightColor),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 45.0),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text("Specialist",
                    style: theme.textTheme.headline3?.copyWith(fontSize: 18)),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: double.infinity,
                height: 150.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    SpecialistCard(
                      name: "Cardio Specialist",
                      color: kGreenColor,
                      doctor: "27",
                      icon: "images/lungs.svg",
                    ),
                    SpecialistCard(
                      name: "Heart\nIssue",
                      color: kBlueColor,
                      doctor: "57",
                      icon: "images/doctor.svg",
                    ),
                    SpecialistCard(
                      name: "Dental\nCard",
                      color: kOrangeColor,
                      doctor: "17",
                      icon: "images/dentist.svg",
                    ),
                    SpecialistCard(
                      name: "Physio\nTherapy",
                      color: kPurpleColor,
                      doctor: "32",
                      icon: "images/wheelchair.svg",
                    ),
                    SpecialistCard(
                      name: "Eyes\nSpecialist",
                      color: kGreenColor,
                      doctor: "32",
                      icon: "images/ophtalmology.svg",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                width: double.infinity,
                height: 150.0,
                child: ListView.builder(
                  itemCount: consultationList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = consultationList[index];
                    return ConsultationCard(consultation: item);
                  },
                ),
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: <Widget>[
                    Text("Top Doctor",
                        style:
                            theme.textTheme.headline3?.copyWith(fontSize: 18)),
                    const Spacer(),
                    Text("View all", style: theme.textTheme.subtitle1),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 200.0,
                child: ListView.builder(
                  itemCount: doctorList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var doctor = doctorList[index];

                    return DoctorCard(doctor: doctor);
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
