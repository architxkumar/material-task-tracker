import 'package:logger/logger.dart';
import 'package:material_task_tracker/data/service/database_service.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/domain/model/list.dart';
import 'package:result_dart/result_dart.dart';

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

  /// Returns true if the list was inserted successfully
  Future<Result<bool>> insertList(ListDomain list) async {
    try {
      final listCount = (await _databaseService.getAllLists()).length;
      await _databaseService.insertList(
        list.copyWith(sortOrder: listCount),
      );
      _logger.i('List added successfully');
      return const Success(true);
    } catch (e, s) {
      _logger.e('Error adding list', error: e, stackTrace: s);
      return Failure(Exception(false));
    }
  }
}
