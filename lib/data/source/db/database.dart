import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
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
  late final Column<DateTime> createdAt = dateTime().withDefault(
    currentDateAndTime,
  )();
  late final Column<DateTime> updatedAt = dateTime().withDefault(
    currentDateAndTime,
  )();
  late final Column<int> sortOrder = integer().withDefault(
    const Constant(0),
  )();
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

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
