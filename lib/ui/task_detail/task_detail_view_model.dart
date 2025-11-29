import 'package:flutter/material.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_screen.dart';
import 'package:result_dart/result_dart.dart';

class TaskDetailViewModel extends ChangeNotifier {
  TaskDetailViewModel(TaskRepository taskRepository)
    : _taskRepository = taskRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TaskRepository _taskRepository;
  // Initialize with a default empty task which will be replaced when loading a real task
  Task _task = Task(
    id: 0,
    title: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    sortOrder: 0,
  );

  Task get task => _task;

  /// Load the task into the view model.
  ///
  /// Called from initState of [TaskDetailScreen].
  ///
  /// After loading, the UI reads the task through the getter.
  void loadTask(Task task) {
    _task = task;
  }

  Future<Result<bool>> deleteTask() async {
    _isLoading = true;
    notifyListeners();
    final result = await _taskRepository.deleteTask(_task);
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
