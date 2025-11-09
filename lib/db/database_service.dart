import 'package:drift/drift.dart';
import 'package:material_task_tracker/db/database.dart';
import 'package:material_task_tracker/model/task.dart';

class DatabaseService {
  final AppDatabase _database;

  DatabaseService(AppDatabase appDatabase) : _database = appDatabase;

  /// Returns the `id` of the task after insertion
  Future<int> insertTask(Task task) async {
    return _database
        .into(_database.todoItems)
        .insert(
          TodoItemsCompanion(
            body: Value(task.body),
            completed: Value(task.completed),
          ),
        );
  }

  /// Returns stream of the tasks in the database
  Stream<List<Task>> watchAllTasks() => _database
      .select(_database.todoItems)
      .map(
        (entry) => Task(
          id: entry.id,
          body: entry.title,
          completed: entry.completed,
        ),
      )
      .watch();

  /// Returns `true` if any row was affected by the operation
  Future<bool> updateTask(Task task) async => (task.id == null)
      ? false
      : await _database
            .update(_database.todoItems)
            .replace(
              TodoItemsCompanion(
                id: Value(task.id!),
                body: Value(task.body),
                completed: Value(task.completed),
              ),
            );

  /// Returns the `id` of the task after deletion
  Future<int> deleteTask(Task task) async => (task.id == null)
      ? 0
      : await (_database.delete(_database.todoItems)..where(
              (tbl) => tbl.id.isValue(task.id!),
            ))
            .go();
}
