part of 'departmentsanddoctors_bloc.dart';

@immutable
abstract class DepartmentsanddoctorsEvent {}

class DepartmentsanddoctorsInitialEvent extends DepartmentsanddoctorsEvent {
  final List<List<String>> doctorsIdList;
  final BuildContext context;
  DepartmentsanddoctorsInitialEvent({
    required this.doctorsIdList,
    required this.context,
  });
}
