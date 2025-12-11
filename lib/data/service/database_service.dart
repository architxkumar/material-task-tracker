import 'package:drift/drift.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/domain/model/task.dart';

class DatabaseService {
  final AppDatabase _database;

  DatabaseService(AppDatabase appDatabase) : _database = appDatabase;

  /// Returns the `id` of the inserted task
  Future<int> insertTask(Task task) {
    return _database
        .into(_database.todoItems)
        .insert(
          TodoItemsCompanion(
            title: Value(task.title),
            body: task.body == null ? const Value.absent() : Value(task.body!),
            completed: Value(task.completed),
            dueDate: task.dueDate == null
                ? const Value.absent()
                : Value(task.dueDate!),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
            sortOrder: Value(task.sortOrder),
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

  Future<List<Task>> getAllTasks() => _database
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
      .get();

  /// Returns `true` if any row was affected by the operation
  Future<bool> updateTask(Task task) => _database
      .update(_database.todoItems)
      .replace(
        TodoItemsCompanion(
          id: Value(task.id),
          title: Value(task.title),
          body: (task.body != null) ? Value(task.body!) : const Value.absent(),
          dueDate: (task.dueDate != null)
              ? Value(task.dueDate!)
              : const Value.absent(),
          createdAt: Value(task.createdAt),
          updatedAt: Value(DateTime.now()),
          sortOrder: Value(task.sortOrder),
          completed: Value(task.completed),
        ),
      );

  /// Returns the amount of rows affected after deletion
  Future<int> deleteTask(Task task) => (_database.delete(
    _database.todoItems,
  )..where((tbl) => tbl.id.isValue(task.id))).go();
}
