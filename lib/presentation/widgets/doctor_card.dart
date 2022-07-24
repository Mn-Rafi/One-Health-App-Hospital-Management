import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
// import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/presentation/screen_book_appointment/screen_book_appointment.dart';
import 'package:one_health_hospital_app/presentation/screen_doctor_profile/screen_doctor_profile.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class DoctorCard extends StatelessWidget {
  final DoctorResponseModel doctor;
  final bool? isSearching;

  const DoctorCard({Key? key, required this.doctor, this.isSearching = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ScreenDoctorProfile(doctor: doctor),
        ));
      },
      child: Card(
        color: theme.primaryColorLight,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: 'doctor_profile_${doctor.doctor!.name}',
                      child: SizedBox(
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Image.network(
                            gaplessPlayback: true,
                            doctor.doctor!.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${doctor.doctor!.name}',
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15),
                  ),
                  if (isSearching!)
                    Text(doctor.doctor!.department!,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.subtitle2!
                            .copyWith(fontSize: 15, color: Colors.grey)),
                  const SizedBox(height: 6.0),
                  Text(doctor.doctor!.qualification!,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.subtitle2!
                          .copyWith(fontSize: 14, color: Colors.brown[900])),
                  const SizedBox(height: 4.0),
                  // Text(doctor.doctor!.experience!,
                  //     overflow: TextOverflow.clip,
                  //     maxLines: 1,
                  //     textAlign: TextAlign.center,
                  //     style: theme.textTheme.subtitle2!
                  //         .copyWith(fontSize: 14, color: Colors.brown[900])),
                  SizedBox(
                    width: 42.w,
                    child: Text(doctor.doctor!.expertise!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.subtitle2!
                            .copyWith(fontSize: 14, color: Colors.brown[900])),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ScreenDoctorProfile(doctor: doctor),
                          ));
                        },
                        child: CustomSubmitButton(
                          text: 'Profile',
                          bgColor: Colors.green,
                          width: 17.w,
                          height: 3.h,
                          fontSize: 11.sp,
                          borderRadius: 1.w,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ScreenBookAppointment(doctor: doctor),
                              ));
                        },
                        child: CustomSubmitButton(
                          text: 'Book',
                          bgColor: Colors.red,
                          width: 17.w,
                          height: 3.h,
                          fontSize: 11.sp,
                          borderRadius: 1.w,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCardShimmer extends StatelessWidget {
  const DoctorCardShimmer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(left: 18.0, bottom: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 150.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.blueGrey[100]!,
                    highlightColor: Colors.white,
                    child: Image.asset(
                      'images/file-20191203-66986-im7o5.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Shimmer.fromColors(
              baseColor: Colors.blueGrey[100]!,
              highlightColor: Colors.white,
              child: Text(
                'Dr. OneHealth',
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 6.0),
            Shimmer.fromColors(
              baseColor: Colors.blueGrey[100]!,
              highlightColor: Colors.white,
              child: Text(
                'Department',
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: theme.textTheme.subtitle2!.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
