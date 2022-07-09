import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_home_page/homepage_bloc.dart';
import 'package:one_health_hospital_app/logic/models/doctor.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/presentation/widgets/consultation_card.dart';
import 'package:one_health_hospital_app/presentation/widgets/doctor_card.dart';
import 'package:one_health_hospital_app/presentation/widgets/specialist_card.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:shimmer/shimmer.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: kboxdecoration,
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
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
                          image: NetworkImage(state is HomepageInitialState
                              ? state.userImage
                              : state is HomePageFetchDoctorsSuccessState
                                  ? state.userImage
                                  : 'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                        state is HomepageInitialState
                            ? state.userName
                            : state is HomePageFetchDoctorsSuccessState
                                ? state.userName
                                : 'Welcome',
                        style:
                            theme.textTheme.headline3?.copyWith(fontSize: 18)),
                    subtitle: Text(
                      "Find your doctor here",
                      style: theme.textTheme.subtitle2,
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: theme.cardColor,
                      ),
                      child: IconButton(
                        icon:
                            const Icon(Icons.search, color: kPrimaryLightColor),
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
                  // const SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text("Specialist",
                        style:
                            theme.textTheme.headline3?.copyWith(fontSize: 18)),
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state is HomePageFetchDoctorsSuccessState
                            ? state.departmentList?.length
                            : 5,
                        itemBuilder: (context, index) {
                          if (state is HomePageFetchDoctorsSuccessState) {
                            return SpecialistCard(
                              name: state.departmentList![index].name!,
                              color: cardsColorsList[index],
                              doctor: state
                                  .departmentList![index].doctors!.length
                                  .toString(),
                              icon: "images/doctor.svg",
                            );
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.red[300]!.withOpacity(0.1),
                            highlightColor: Colors.grey[200]!.withOpacity(0.4),
                            child: SpecialistCard(
                              name: 'One Health',
                              color: cardsColorsList[index],
                              doctor: '2',
                              icon: "images/doctor.svg",
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text("Appointments",
                        style:
                            theme.textTheme.headline3?.copyWith(fontSize: 18)),
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: ListView.builder(
                      itemCount: state is HomePageFetchDoctorsSuccessState
                          ? state.appointmentList!.isEmpty
                              ? 1
                              : state.appointmentList!.length
                          : 5,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (state is HomePageFetchDoctorsSuccessState) {
                          if (state.appointmentList!.isEmpty) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150.0,
                              child: Center(
                                child: Text(
                                  'No Appointments Found',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            );
                          }
                          return AppoinmentCard(
                              appointment: state.appointmentList![index]);
                        }
                        return const AppoinmentCardShimmer();
                      },
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: <Widget>[
                        Text("Top Doctors",
                            style: theme.textTheme.headline3?.copyWith(
                              fontSize: 18,
                            )),
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
                      itemCount: state is HomePageFetchDoctorsSuccessState
                          ? state.doctorList!.length
                          : 5,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // var doctor = doctorList[index];
                        if (state is HomePageFetchDoctorsSuccessState) {
                          return DoctorCard(doctor: state.doctorList![index]);
                        } else {
                          return DoctorCardShimmer();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
