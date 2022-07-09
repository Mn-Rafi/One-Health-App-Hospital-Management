import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/logic/models/all_doctor_response_model.dart';
import 'package:shimmer/shimmer.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Image.network(
                  doctor.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Dr. ${doctor.name!}',
              overflow: TextOverflow.clip,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 6.0),
            Text(doctor.department!,
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: theme.textTheme.subtitle2!.copyWith(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 5.0),
          ],
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
