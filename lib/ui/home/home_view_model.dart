import 'package:flutter/material.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/model/app_bar.dart';
import 'package:result_dart/result_dart.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(TaskRepository taskRepository)
    : _taskRepository = taskRepository;

  final TaskRepository _taskRepository;

  // ---------------------------------------------------------------------------
  // App Bar
  // ---------------------------------------------------------------------------

  // The app bar UI state
  final HomeAppBarUiState _appBarUiState = HomeAppBarUiState();

  HomeAppBarUiState get appBarUiState => _appBarUiState;

  Stream<int> get completedTaskCount => _taskRepository.getTasksStream().map(
    (tasks) => tasks.where((task) => task.completed).length,
  );

  Stream<int> get pendingTaskCount => _taskRepository.getTasksStream().map(
    (tasks) => tasks.where((task) => !task.completed).length,
  );

  void onHideCompletedTasksIconPressed() {
    _appBarUiState.isHideCompletedTasksIconActive =
        !_appBarUiState.isHideCompletedTasksIconActive;
    notifyListeners();
  }

  // Note 1: No manual pull to refresh is needed as the stream will emit new values automatically
  // Note 2: For task filtering, another method I came up with was filtering at the stream level
  // but since the appBar needs raw list of tasks; that's why I ditched that
  Stream<List<Task>> get taskStream => _taskRepository.getTasksStream();

  Future<Result<bool>> deleteTask(Task task) =>
      _taskRepository.deleteTask(task);

  Future<Result<bool>> updateTask(Task task) =>
      _taskRepository.updateTask(task);

  Future<Result<bool>> insertTask(String title) => _taskRepository.insertTask(
    Task(
      title: title.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      // TODO: Update sort order logic when adding filtering options
      sortOrder: 0,
    ),
  );

  List<Task> filterTasksList(List<Task> taskList) {
    if (_appBarUiState.isHideCompletedTasksIconActive) {
      taskList = taskList.where((task) => !task.completed).toList();
    }
    // More filtering logic can be added in the future here
    return taskList;
  }
}
