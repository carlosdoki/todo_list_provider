import 'tasks_model.dart';

class WeekTaskModel {
  WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });

  final DateTime startDate;
  final DateTime endDate;
  final List<TasksModel> tasks;
}
