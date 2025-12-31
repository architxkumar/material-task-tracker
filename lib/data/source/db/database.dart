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

  // NOTE: Since the values are being set in the service, we don't set
  // default values here.
  late final Column<DateTime> createdAt = dateTime()();
  late final Column<DateTime> updatedAt = dateTime()();

  // NOTE: Default value is supplied to deal with migration
  late final Column<int> sortOrder = integer().withDefault(
    const Constant(0),
  )();
}

class ListItems extends Table {
  late final Column<int> id = integer().autoIncrement()();
  late final Column<String> title = text().unique().withLength(min: 1)();

  // NOTE: Default value isn't needed as it's a fresh instance rather than migration
  late final Column<int> sortOrder = integer().customConstraint(
    'NOT NULL UNIQUE CHECK(sortOrder >= 0)',
  )();
  late final Column<bool> isDefault = boolean().withDefault(
    const Constant(false),
  )();

  // NOTE: The service will set these values
  late final Column<DateTime> createdAt = dateTime()();
  late final Column<DateTime> updatedAt = dateTime()();

  /// Unicode value of the emoji
  /// E.g. U+1F600 for 😀
  late final Column<String> emoji = text().nullable()();

  /// The hex value of the color
  /// E.g. #FF5733
  late final Column<String> color = text().nullable()();
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
