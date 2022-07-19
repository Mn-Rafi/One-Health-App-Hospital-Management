part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomepageInitialState extends HomepageState {
  final String userName;
  final String userImage;
  HomepageInitialState({
    required this.userName,
    required this.userImage,
  });
}

class HomePageFetchDoctorsSuccessState extends HomepageState {
  final List<Doctor>? doctorList;
  final String userImage;
  final String userName;
  final List<Prescription>? prescriptionList;
  final List<Appointment>? appointmentList;
  final List<Department>? departmentList;
  HomePageFetchDoctorsSuccessState({
    this.doctorList,
    required this.userImage,
    required this.userName,
    this.prescriptionList,
    this.appointmentList,
    required this.departmentList,
  });
}

class HomePageNavigateToDepartmentsState extends HomepageState {
  final int currentIndex;

  final List<Department> department;
  HomePageNavigateToDepartmentsState({
    required this.currentIndex,
    required this.department,
  });
}
