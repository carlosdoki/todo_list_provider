import '../../models/tasks_model.dart';

mixin TasksRepository {
  Future<void> save(DateTime date, String description) async {}
  Future<List<TasksModel>> findByPeriod(DateTime start, DateTime end);
}
