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

  factory TasksModel.loadFromDB(Map<String, dynamic> task) {
    return TasksModel(
      id: task['id'],
      description: task['description'],
      dateTime: DateTime.parse(task['dateTime']),
      finished: task['finished'] == 1,
    );
  }
}
