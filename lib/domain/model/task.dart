// NOTE(architxkumar): Null fields inside this model represents optional fields in the database.

import 'package:material_task_tracker/data/source/db/database.dart';

/// Task models a task in the database.
///
/// For inserting a new task, the [id] field can be left as default (0).
///
/// Null fields correspond to optional database columns.
class Task {
  /// Database id of the task. `0` indicates an unset/new task.
  final int id;

  /// Short, human-readable title of the task.
  final String title;

  /// Optional detailed description or notes for the task.
  final String? body;

  /// Whether the task is completed.
  final bool completed;

  /// Optional due date/time for the task.
  final DateTime? dueDate;

  /// Timestamp when the task was created (set by the server/db).
  final DateTime createdAt;

  /// Timestamp when the task was last updated (set by the server/db).
  final DateTime updatedAt;

  /// Integer used to order tasks in lists.
  final int sortOrder;

  /// Creates a new `Task`.
  ///
  /// - `id` defaults to `0` for new/unsaved tasks.
  /// - `title`, `createdAt`, `updatedAt`, and `sortOrder` are required.
  /// - `body` and `dueDate` are optional.
  /// - `completed` defaults to `false`.
  /// - `sortOrder` defaults to `0`
  Task({
    this.id = 0,
    required this.title,
    this.body,
    this.completed = false,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    // Added default value to keep the property non-nullable and avoid passing the value from ViewModel to repository
    this.sortOrder = 0,
  });

  /// Returns a copy of this [Task] with provided fields replaced.
  ///
  /// Any argument left `null` (or omitted) retains the original value.
  Task copyWith({
    int? id,
    String? title,
    String? body,
    bool? completed,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? sortOrder,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      completed: completed ?? this.completed,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, body: $body, completed: $completed, dueDate: $dueDate, createdAt: $createdAt, updatedAt: $updatedAt, sortOrder: $sortOrder}';
  }

  static Task fromToDoItem(TodoItem entry) =>
      Task(
        id: entry.id,
        title: entry.title,
        body: entry.body,
        completed: entry.completed,
        dueDate: entry.dueDate,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        sortOrder: entry.sortOrder,
      );
}
