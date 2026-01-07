import 'package:drift/drift.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/domain/model/list.dart';
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

  Future<TodoItem> getTaskBySortOrder(int sortOrder) =>
      (_database.select(
              _database.todoItems,
            )
            ..where((tbl) => tbl.sortOrder.equals(sortOrder))
            ..limit(1))
          .getSingle();

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

  Future<int> decrementSortOrderAfterDeletion(int deletedSortOrder) {
    final tbl = _database.todoItems;

    return (_database.update(
      tbl,
    )..where((t) => t.sortOrder.isBiggerThanValue(deletedSortOrder))).write(
      TodoItemsCompanion.custom(
        sortOrder: tbl.sortOrder - const Constant(1),
      ),
    );
  }

  /// Increments the sort order for tasks having value equal or greater [targetSortOrder]
  Future<int> incrementSortOrderForSelectedTask(int targetSortOrder) {
    final tbl = _database.todoItems;
    return (_database.update(tbl)..where(
          (tbl) => tbl.sortOrder.isBiggerOrEqualValue(targetSortOrder),
        ))
        .write(
          TodoItemsCompanion.custom(
            sortOrder: tbl.sortOrder + const Constant(1),
          ),
        );
  }

  /// Decrement the sort order for tasks having value less than or equal to [targetSortOrder]
  Future<int> decrementSortOrderForSelectedTask(int targetSortOrder) {
    final tbl = _database.todoItems;
    return (_database.update(tbl)..where(
          (tbl) => tbl.sortOrder.isBiggerOrEqualValue(targetSortOrder),
        ))
        .write(
          TodoItemsCompanion.custom(
            sortOrder: tbl.sortOrder + const Constant(1),
          ),
        );
  }

  /// Decrements the sort order for tasks having value greater than [oldIndex]
  Future<int> decrementSortOrderForRemainingTasks(int oldIndex) {
    final tbl = _database.todoItems;
    return (_database.update(
      tbl,
    )..where((tbl) => tbl.sortOrder.isBiggerThanValue(oldIndex))).write(
      TodoItemsCompanion.custom(
        sortOrder: tbl.sortOrder - const Constant(1),
      ),
    );
  }

  /// Returns a stream of [ListItems] DAO from the database
  Stream<List<ListItem>> watchLists() =>
      _database.select(_database.listItems).watch();

  /// Returns the `id` of the inserted list
  Future<int> insertList(ListDomain list) {
    return _database
        .into(_database.listItems)
        .insert(
          ListItemsCompanion(
            sortOrder: Value(list.sortOrder),
            title: Value(list.title),
            color: Value.absentIfNull(list.color),
            emoji: Value.absentIfNull(list.emoji),
            isDefault: const Value(false),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Returns all the lists from the database
  Future<List<ListDomain>> getAllLists() {
    return _database
        .select(_database.listItems)
        .map(
          (entry) => ListDomain(
            id: entry.id,
            title: entry.title,
            sortOrder: entry.sortOrder,
            isDefault: entry.isDefault,
            createdAt: entry.createdAt,
            updatedAt: entry.updatedAt,
            emoji: entry.emoji,
            color: entry.color,
          ),
        )
        .get();
  }
}
