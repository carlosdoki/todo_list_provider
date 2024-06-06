class TasksModel {
  TasksModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;
}
