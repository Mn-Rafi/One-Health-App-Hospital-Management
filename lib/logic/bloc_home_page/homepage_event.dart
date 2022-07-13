part of 'homepage_bloc.dart';

@immutable
class HomepageEvent {}

class HomePageNavigateToDepartments extends HomepageEvent {
  final int currentIndex;
  final List<Department> department;
  HomePageNavigateToDepartments({
    required this.currentIndex,
    required this.department,
  });
}
