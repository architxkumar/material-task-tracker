import 'package:logger/logger.dart';
import 'package:material_task_tracker/data/service/database_service.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:result_dart/result_dart.dart';

class TaskRepository {
  final DatabaseService _databaseService;

  final Logger _logger;

  TaskRepository(AppDatabase appDatabase, Logger logger)
    : _databaseService = DatabaseService(appDatabase),
      _logger = logger;

  /// Returns true if the task was inserted successfully
  Future<Result<bool>> insertTask(Task task) async {
    try {
      await _databaseService.insertTask(task);
      _logger.i('Task added successfully');
      return const Success(true);
    } catch (e, s) {
      _logger.e('Error adding task', error: e, stackTrace: s);
      return Failure(Exception(false));
    }
  }

  Future<Result<List<Task>>> getAllTasks() async {
    try {
      final tasks = await _databaseService.getAllTasks();
      _logger.i('Fetched all tasks successfully');
      return Success(tasks);
    } catch (e, s) {
      _logger.e('Error fetching all tasks', error: e, stackTrace: s);
      return (e is Exception) ? Failure(e) : Failure(Exception(e.toString()));
    }
  }

  /// Returns stream of the tasks in the database
  Stream<List<Task>> getTasksStream() {
    _logger.i('Watching task list');
    return _databaseService.watchAllTasks().handleError((
      Object error,
      StackTrace stackTrace,
    ) {
      _logger.e(
        'Error watching task list',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  /// Returns true if the task was updated successfully
  Future<Result<bool>> updateTask(Task task) async {
    try {
      final bool result = await _databaseService.updateTask(task);
      if (result) {
        _logger.i('Task updated successfully');
        return const Success(true);
      } else {
        _logger.w('No rows affected');
        return const Success(false);
      }
    } catch (e, s) {
      _logger.e('Error updating Task', error: e, stackTrace: s);
      return (e is Exception) ? Failure(e) : Failure(Exception(e.toString()));
    }
  }

  /// Returns true if the task was deleted successfully
  Future<Result<bool>> deleteTask(Task task) async {
    try {
      final int result = await _databaseService.deleteTask(task);
      if (result != 0) {
        _logger.i('Task deleted successfully');
        return const Success(true);
      } else {
        _logger.w('No rows affected');
        return const Success(false);
      }
    } catch (e, s) {
      _logger.e('Error deleting Task', error: e, stackTrace: s);
      return (e is Exception) ? Failure(e) : Failure(Exception(e.toString()));
    }
  }
}
