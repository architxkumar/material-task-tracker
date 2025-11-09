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
            title: Value(task.title),
            body: (task.body != null) ? Value(task.body) : const Value.absent(),
            completed: Value(task.completed ?? false),
            dueDate: (task.dueDate != null)
                ? Value(task.dueDate!)
                : const Value.absent(),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
            sortOrder: (task.sortOrder != null)
                ? Value(task.sortOrder!)
                : const Value.absent(),
          ),
        );
  }

  /// Returns stream of the tasks in the database
  Stream<List<Task>> watchAllTasks() => _database
      .select(_database.todoItems)
      .map(
        (entry) => Task(
          id: entry.id,
          title: entry.title,
          body: entry.body,
          completed: entry.completed,
          dueDate: entry.dueDate,
          createdAt: entry.createdAt,
          updatedAt: entry.updatedAt,
          sortOrder: entry.sortOrder,
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
                title: Value(task.title),
                body: (task.body != null)
                    ? Value(task.body!)
                    : const Value.absent(),
                dueDate: (task.dueDate != null)
                    ? Value(task.dueDate!)
                    : const Value.absent(),
                updatedAt: Value(DateTime.now()),
                sortOrder: (task.sortOrder != null)
                    ? Value(task.sortOrder!)
                    : const Value.absent(),
                completed: Value(task.completed ?? false),
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
