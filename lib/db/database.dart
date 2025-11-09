import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:material_task_tracker/db/database.steps.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class TodoItems extends Table {
  late final Column<int> id = integer().autoIncrement()();
  late final Column<String> title = text()();
  late final Column<String> body = text().nullable()();
  late final Column<bool> completed = boolean().withDefault(
    const Constant(false),
  )();
  late final Column<DateTime> dueDate = dateTime().nullable()();
  // HACK: Making it nullable to avoid issues during migration. In a real app,
  // this should be non-nullable.
  late final Column<DateTime> createdAt = dateTime().nullable()();
  // HACK: Making it nullable to avoid issues during migration. In a real app,
  // this should be non-nullable.
  late final Column<DateTime> updatedAt = dateTime().nullable()();
  late final Column<int> sortOrder = integer().withDefault(
    const Constant(0),
  )();
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.renameColumn(
          schema.todoItems,
          'content',
          schema.todoItems.title,
        );
        await m.addColumn(schema.todoItems, schema.todoItems.body);
        await m.addColumn(schema.todoItems, schema.todoItems.sortOrder);
        await m.addColumn(schema.todoItems, schema.todoItems.dueDate);
        await m.addColumn(schema.todoItems, schema.todoItems.createdAt);
        await m.addColumn(schema.todoItems, schema.todoItems.updatedAt);
      },
    ),
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'tasks_database',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
