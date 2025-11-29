import 'package:flutter/material.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/domain/model/task.dart';

class TaskDetailViewModel extends ChangeNotifier {
  TaskDetailViewModel(TaskRepository taskRepository)
    : _taskRepository = taskRepository;

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

  void loadTask(Task task) {
    _task = task;
  }
}
