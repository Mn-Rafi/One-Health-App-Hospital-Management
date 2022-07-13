import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

import 'package:one_health_hospital_app/logic/bloc_home_page/homepage_bloc.dart';
import 'package:one_health_hospital_app/logic/models/all_departments_response_model.dart';

class SpecialistCard extends StatelessWidget {
  final List<Department>? departments;
  final int index;
  final String name;
  final String doctor;
  final String icon;
  final Color color;

  const SpecialistCard({
    Key? key,
    this.departments,
    required this.index,
    required this.name,
    required this.doctor,
    required this.icon,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 110.0,
      margin: const EdgeInsets.only(left: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: () {
          context
              .read<HomepageBloc>()
              .add(HomePageNavigateToDepartments(department: departments!, currentIndex: index));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              icon,
              width: 45.0,
              color: Colors.white,
            ),
            const SizedBox(height: 12.0),
            Text(
              name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headline3
                  ?.copyWith(height: 1.0, color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 5.0),
            Text("$doctor Doctors",
                style: theme.textTheme.subtitle2
                    ?.copyWith(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
