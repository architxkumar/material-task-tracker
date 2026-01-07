import 'package:logger/logger.dart';
import 'package:material_task_tracker/data/service/database_service.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/domain/model/list.dart';

class ListRepository {
  final DatabaseService _databaseService;

  final Logger _logger;

  ListRepository(AppDatabase appDatabase, Logger logger)
    : _databaseService = DatabaseService(appDatabase),
      _logger = logger;

  /// Returns stream of the lists in the database.
  /// Maps the database [ListItem] to domain [ListDomain] models.
  Stream<List<ListDomain>> watchLists() {
    _logger.i("Watching list categories list");
    return _databaseService
      .watchLists()
      .map(
        (entry) => entry
            .map(
              (element) => ListDomain.fromListItem(element),
            )
            .toList(),
      )
      .handleError((
        Object error,
        StackTrace stackTrace,
      ) {
        _logger.e(
          'Error watching lists',
          error: error,
          stackTrace: stackTrace,
        );
      });
  }
}
