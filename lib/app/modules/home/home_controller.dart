import '../../core/notifier/default_change_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../../models/tasks_model.dart';
import '../../models/total_tasks_model.dart';
import '../../models/week_task_model.dart';
import '../../services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? totalTasksModel;
  TotalTasksModel? tomorrowTotalTasksModel;
  TotalTasksModel? weekTotalTasksModel;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TasksModel>;
    final tomorrowTasks = allTasks[1] as List<TasksModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    totalTasksModel = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTaskFinish: todayTasks.where((task) => task.finished).length,
    );
    tomorrowTotalTasksModel = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTaskFinish: tomorrowTasks.where((task) => task.finished).length,
    );
    weekTotalTasksModel = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTaskFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }
}
