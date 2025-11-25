import 'package:flutter/material.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:result_dart/result_dart.dart';

class HomeViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;

  HomeViewModel(TaskRepository taskRepository)
    : _taskRepository = taskRepository;

  Stream<List<Task>> get taskStream => _taskRepository.getTasksStream();

  Future<Result<bool>> deleteTask(Task task) =>
      _taskRepository.deleteTask(task);

  Future<Result<bool>> updateTask(Task task) =>
      _taskRepository.updateTask(task);

  Future<Result<bool>> insertTask(Task task) =>
      _taskRepository.insertTask(task);
}
