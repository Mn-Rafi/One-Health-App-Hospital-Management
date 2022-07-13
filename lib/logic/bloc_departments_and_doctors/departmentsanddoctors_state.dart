part of 'departmentsanddoctors_bloc.dart';

@immutable
abstract class DepartmentsanddoctorsState {}

class DepartmentsanddoctorsInitial extends DepartmentsanddoctorsState {}

class DoctorsDetailsLoadingState extends DepartmentsanddoctorsState {}

class DoctorsDetailsLoadedState extends DepartmentsanddoctorsState {
  final List<List<DoctorResponseModel>>? doctorList;
  DoctorsDetailsLoadedState({
    required this.doctorList,
  });
}