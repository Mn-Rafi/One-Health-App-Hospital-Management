import 'dart:developer';

import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_departments_and_doctors/departmentsanddoctors_bloc.dart';
import 'package:one_health_hospital_app/logic/models/all_departments_response_model.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
// import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart';
// import 'package:one_health_hospital_app/logic/models/all_doctor_response_model.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/presentation/widgets/doctor_card.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';

import 'package:one_health_hospital_app/themedata.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:sizer/sizer.dart';

class ScreenDepartments extends StatelessWidget {
  final bool? isSearching;
  final List<Department>? department;
  final int currentIndex;

  final TextEditingController _searchTextController = TextEditingController();
  ScreenDepartments(
      {Key? key,
      required this.department,
      this.isSearching = false,
      required this.currentIndex})
      : super(key: key);

  final List<List<String>> listOfDoctors = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < department!.length; i++) {
      listOfDoctors.add(department![i].doctors!);
    }
    log('***********');
    print(listOfDoctors.toString());
    log('***********');

    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) {
        return DepartmentsanddoctorsBloc(
          RepositoryProvider.of<GetAllDoctorsServices>(context),
        );
      },
      child: Builder(builder: (context) {
        context
            .read<DepartmentsanddoctorsBloc>()
            .add(DepartmentsanddoctorsInitialEvent(
              context: context,
              doctorsIdList: listOfDoctors,
            ));
        return Container(
          decoration: kboxdecoration,
          child: Scaffold(
            appBar: !isSearching!
                ? AppBar(
                    elevation: 0,
                    title: Text(
                      "Departments",
                      style: theme.textTheme.subtitle2!.copyWith(fontSize: 16),
                    ),
                    centerTitle: true,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  )
                : null,
            body: !isSearching!
                ? ListView.builder(
                    itemCount: department!.length,
                    itemBuilder: (context, index) {
                      return CustomExpansionTileForDoctorsList(
                          currentIndex: currentIndex,
                          department: department!,
                          theme: theme,
                          index: index);
                    },
                  )
                : SafeArea(
                    child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: CustomTextFormField(
                              hintText: 'Search doctor, department,...',
                              keyBoardType: TextInputType.text,
                              iconData: Icons.search,
                              textController: _searchTextController),
                        ),
                      ),
                      Expanded(child: BlocBuilder<DepartmentsanddoctorsBloc,
                          DepartmentsanddoctorsState>(
                        builder: (context, state) {
                          if (state is DoctorsDetailsLoadedState) {
                            
                          }
                          return ListView.builder(
                              itemCount: state is DoctorsDetailsLoadedState
                                  ? state.doctorList!.length
                                  : 2,
                              itemBuilder: (context, index) {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: department![index].doctors!.length,
                                  itemBuilder: (context, ind) {
                                    if (state is DoctorsDetailsLoadedState) {
                                      return Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 8.0,
                                              ),
                                              child: SizedBox(
                                                  height: 150,
                                                  child: DoctorCard(
                                                      isSearching: true,
                                                      doctor: state.doctorList![
                                                          index][ind])),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CardLoading(
                                        cardLoadingTheme: CardLoadingTheme(
                                          colorOne: Colors.white54,
                                          colorTwo: Colors.white30,
                                        ),
                                        height: 40,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        margin: EdgeInsets.only(bottom: 3),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                      ))
                    ],
                  )),
          ),
        );
      }),
    );
  }
}

class CustomExpansionTileForDoctorsList extends StatelessWidget {
  const CustomExpansionTileForDoctorsList({
    Key? key,
    required this.currentIndex,
    required this.department,
    required this.theme,
    required this.index,
  }) : super(key: key);

  final int currentIndex;
  final List<Department> department;
  final ThemeData theme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: ExpansionTileCard(
        initiallyExpanded: currentIndex == index,
        expandedTextColor: Colors.white,
        baseColor: cardsColorsList[currentIndex],
        expandedColor: cardsColorsList[index],
        title: Text(
          department[index].name!,
          style: theme.textTheme.headline3
              ?.copyWith(height: 1.0, color: Colors.white, fontSize: 16),
        ),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          BlocBuilder<DepartmentsanddoctorsBloc, DepartmentsanddoctorsState>(
            builder: (context, state) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: department[index].doctors!.length,
                itemBuilder: (context, ind) {
                  if (state is DoctorsDetailsLoadedState) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: SizedBox(
                                height: 150,
                                child: DoctorCard(
                                    doctor: state.doctorList![index][ind])),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CardLoading(
                      cardLoadingTheme: CardLoadingTheme(
                        colorOne: Colors.white54,
                        colorTwo: Colors.white30,
                      ),
                      height: 40,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      margin: EdgeInsets.only(bottom: 3),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ButtonBar(
//                           alignment: MainAxisAlignment.spaceAround,
//                           buttonHeight: 52.0,
//                           buttonMinWidth: 90.0,
//                           children: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 // cardA.currentState?.expand();
//                               },
//                               child: Column(
//                                 children: const [
//                                   Icon(Icons.arrow_downward),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 2.0),
//                                   ),
//                                   Text('Open'),
//                                 ],
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // cardA.currentState?.collapse();
//                               },
//                               child: Column(
//                                 children: <Widget>[
//                                   const Icon(Icons.arrow_upward),
//                                   const Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 2.0),
//                                   ),
//                                   const Text('Close'),
//                                 ],
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // cardA.currentState?.toggleExpansion();
//                               },
//                               child: Column(
//                                 children: <Widget>[
//                                   const Icon(Icons.swap_vert),
//                                   const Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 2.0),
//                                   ),
//                                   const Text('Toggle'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),