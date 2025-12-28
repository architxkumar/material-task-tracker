import 'package:flutter/material.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/data/repository/user_preference_repository.dart';
import 'package:material_task_tracker/domain/model/sort.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/model/app_bar.dart';
import 'package:result_dart/result_dart.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(
    TaskRepository taskRepository,
    UserPreferenceRepository userPreferenceRepository,
  ) : _taskRepository = taskRepository,
      _userPreferenceRepository = userPreferenceRepository;

  final TaskRepository _taskRepository;
  final UserPreferenceRepository _userPreferenceRepository;

  // ---------------------------------------------------------------------------
  // App Bar
  // ---------------------------------------------------------------------------

  // The app bar UI state
  HomeAppBarUiState _appBarUiState = HomeAppBarUiState();

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

  void onSortOrderSelectionChange(SortMode sortMode) async {
    final result = await _userPreferenceRepository.setSortMode(sortMode);
    if (result.isSuccess()) {
      final result = await _userPreferenceRepository.getSortMode();
      if (result.isSuccess()) {
        final sortMode = result.getOrDefault(SortMode.createdAt);
        _appBarUiState = _appBarUiState.copyWith(sortMode: sortMode);
        notifyListeners();
      }
    }
  }

  Future<void> loadUserSortOrderPreference() async {
    final result = await _userPreferenceRepository.getSortMode();
    _appBarUiState = _appBarUiState.copyWith(sortMode: result.getOrNull());
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Task Detail Dialog
  // ---------------------------------------------------------------------------

  Task? _selectedTask;

  Task? get selectedTask => _selectedTask;

  void setSelectedTask(Task task) {
    _selectedTask = task;
    notifyListeners();
  }

  Future<Result<bool>> updatedSelectedTask(Task task) async {
    final result = await _taskRepository.updateTask(task);
    if (result.isSuccess()) {
      _selectedTask = task;
      notifyListeners();
    }
    return result;
  }

  // ---------------------------------------------------------------------------
  // General Task Operations
  // ---------------------------------------------------------------------------

  // Note 1: No manual pull to refresh is needed as the stream will emit new values automatically
  // Note 2: For task filtering, another method I came up with was filtering at the stream level
  // but since the appBar needs raw list of tasks; that's why I ditched that
  Stream<List<Task>> get taskStream => _taskRepository.getTasksStream();

  Future<Result<bool>> deleteTask(Task task) =>
      _taskRepository.deleteTask(task);

  // This method is should be used internally most of the time.
  // Since, task can be marked completed from the task list itself.
  Future<Result<bool>> updateTask(Task task) =>
      _taskRepository.updateTask(task);

  Future<Result<bool>> insertTask(String title) => _taskRepository.insertTask(
    Task(
      title: title.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  );

  List<Task> filterTasksList(List<Task> taskList) {
    // Visibility filtering
    if (_appBarUiState.isHideCompletedTasksIconActive) {
      taskList = taskList.where((task) => !task.completed).toList();
    }
    // Sort Order filtering
    if (_appBarUiState.sortMode == SortMode.createdAt) {
      taskList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (_appBarUiState.sortMode == SortMode.dueDate) {
      taskList.sort((a, b) {
        final aDate = a.dueDate;
        final bDate = b.dueDate;

        // Rule 1: nulls go last
        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;

        // Rule 2: both non-null then compare via date
        return aDate.compareTo(bDate);
      } );
    }
    if (_appBarUiState.sortMode == SortMode.manual) {
      taskList.sort((a, b) => a.sortOrder.compareTo(b.sortOrder),);
    }
    // More filtering logic can be added in the future here
    return taskList;
  }

  Future<Result<bool>> reorderTasks(int oldIndex, int newIndex) => _taskRepository.reorderTasks(oldIndex, newIndex);
}
