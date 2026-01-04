import 'package:drift/drift.dart';
import 'package:drift/internal/versioned_schema.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:material_task_tracker/data/source/db/database.steps.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// NOTE: The file makes usage of deprecated `issueCustomQuery` as a hack
// ignore_for_file: deprecated_member_use


class TodoItems extends Table {
  late final Column<int> id = integer().autoIncrement()();
  late final Column<String> title = text()();
  late final Column<String> body = text().nullable()();
  late final Column<bool> completed = boolean().withDefault(
    const Constant(false),
  )();
  late final Column<DateTime> dueDate = dateTime().nullable()();
  // NOTE: The default value of 1 is going with the fact that default list `My Tasks` have primary key as 1
  late final Column<int> listId = integer().references(ListItems, #id).withDefault(const Constant(1))();

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
    'NOT NULL UNIQUE CHECK(sort_order >= 0)',
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

@DriftDatabase(tables: [TodoItems, ListItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  static const _defaultListQuery =
      """INSERT INTO list_items (title, sort_order, is_default, created_at, updated_at)
            VALUES ('My Tasks', 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        """;
  static const _blockUpdatingDefaultListQuery = """
        CREATE TRIGGER IF NOT EXISTS block_updating_default_list
BEFORE UPDATE ON list_items
FOR EACH ROW
WHEN OLD.is_default = 1
BEGIN
  SELECT RAISE(ABORT, 'You cannot update the default list');
END;
        """;
  static const _blockDeletingDefaultListQuery = """
      CREATE TRIGGER IF NOT EXISTS block_deleting_default_list
      BEFORE DELETE ON list_items
      FOR EACH ROW
      WHEN OLD.is_default = 1
      BEGIN
        SELECT RAISE(ABORT, 'You cannot delete the default list');
      END;
      """;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await m.issueCustomQuery(_defaultListQuery);
        // NOTE: Trigger to prevent updating the default list
        await m.issueCustomQuery(_blockUpdatingDefaultListQuery);
        // NOTE: Trigger to prevent deleting the default list
        await m.issueCustomQuery(_blockDeletingDefaultListQuery);
      },
      onUpgrade: (m, from, to) async {
        await customStatement('PRAGMA foreign_keys = OFF');
        await transaction(
          () => VersionedSchema.runMigrationSteps(
            migrator: m,
            from: from,
            to: to,
            steps: _upgrade,
          ),
        );
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static final _upgrade = migrationSteps(
    from1To2: (m, schema) async {
      await m.createTable(schema.listItems);
      await m.issueCustomQuery(_defaultListQuery);
      // NOTE: Trigger to prevent updating the default list
      await m.issueCustomQuery(_blockUpdatingDefaultListQuery);
      // NOTE: Trigger to prevent deleting the default list
      await m.issueCustomQuery(_blockDeletingDefaultListQuery);
      await m.addColumn(schema.todoItems, schema.todoItems.listId);
    },
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
