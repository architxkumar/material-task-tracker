import 'package:flutter/material.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/model/task_creation_draft.dart';
import 'package:result_dart/result_dart.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(TaskRepository taskRepository)
    : _taskRepository = taskRepository;

  final TaskRepository _taskRepository;

  bool _isLoading = false;

  bool get isTaskCompleted => _taskCreationDraft.completed;

  bool get isLoading => _isLoading;

  // The draft is not being exposed to UI to avoid conflicts with text field controllers
  TaskCreationDraft _taskCreationDraft = TaskCreationDraft(title: '');

  TaskCreationDraft get taskCreationDraft => _taskCreationDraft;

  // Note: No manual pull to refresh is needed as the stream will emit new values automatically
  Stream<List<Task>> get taskStream => _taskRepository.getTasksStream();

  Stream<int> get completedTaskCount => _taskRepository.getTasksStream().map(
    (tasks) => tasks.where((task) => task.completed).length,
  );

  Stream<int> get pendingTaskCount => _taskRepository.getTasksStream().map(
    (tasks) => tasks.where((task) => !task.completed).length,
  );

  Future<int> nextSortOrder() async {
    final ResultDart<List<Task>, Exception> result = await _taskRepository
        .getAllTasks();
    if (result.isSuccess()) {
      final List<Task> tasks = result.getOrDefault([]);
      if (tasks.isEmpty) {
        return 0;
      } else {
        final int taskCount = tasks.length;
        return taskCount + 1;
      }
    } else {
      return 0;
    }
  }

  Future<List<Task>> getAllTasks() =>
      _taskRepository.getAllTasks().then((result) => result.getOrDefault([]));

  Future<Result<bool>> deleteTask(Task task) =>
      _taskRepository.deleteTask(task);

  Future<Result<bool>> updateTask(Task task) =>
      _taskRepository.updateTask(task);

  Future<Result<bool>> insertTask(Task task) =>
      _taskRepository.insertTask(task);

  // No side effect on UI, so no notifyListeners call
  void onTaskCreationModalDismissal() =>
      _taskCreationDraft = TaskCreationDraft(title: '');

  void onTitleFieldChange(String value) {
    _taskCreationDraft = _taskCreationDraft.copyWith(title: value);
    notifyListeners();
  }

  // No side effect on UI, so no notifyListeners call
  void onBodyFieldChange(String value) =>
      _taskCreationDraft = _taskCreationDraft.copyWith(body: value);

  void onCompletedCheckboxChange(bool? value) {
    _taskCreationDraft = _taskCreationDraft.copyWith(completed: value ?? false);
    notifyListeners();
  }

  void enableTaskSavingState() {
    _isLoading = true;
    notifyListeners();
  }

  void disableTaskSavingState() {
    _isLoading = false;
    notifyListeners();
  }

  Future<Result<bool>> saveTask() async {
    final Task task = Task(
      id: 0,
      title: _taskCreationDraft.title,
      body: _taskCreationDraft.body,
      completed: _taskCreationDraft.completed,
      dueDate: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      sortOrder: await nextSortOrder(),
    );
    final Result<bool> result = await insertTask(task);

    return result;
  }
}
