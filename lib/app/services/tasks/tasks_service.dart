import '../../models/tasks_model.dart';
import '../../models/week_task_model.dart';

abstract interface class TasksService {
  Future<void> save(DateTime date, String description);
  Future<List<TasksModel>> getToday();
  Future<List<TasksModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
}
