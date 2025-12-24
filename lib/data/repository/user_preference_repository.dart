import 'package:logger/logger.dart';
import 'package:material_task_tracker/data/service/shared_preferences_service.dart';
import 'package:material_task_tracker/domain/model/sort.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceRepository {
  final SharedPreferencesService _sharedPreferencesService;
  final Logger _logger;

  UserPreferenceRepository(
    SharedPreferencesAsync sharedPreferencesAsync,
    Logger logger,
  ) : _sharedPreferencesService = SharedPreferencesService(
        sharedPreferencesAsync,
      ),
      _logger = logger;

  Future<Result<bool>> setSortMode(SortMode sortMode) async {
    try {
      await _sharedPreferencesService.setString('sort_mode', sortMode.name);
      return const Success(true);
    } catch (error, stackTrace) {
      _logger.e('Error setting sort mode', error: error, stackTrace: stackTrace);
      return Failure(error as Exception);
    }
  }

  Future<Result<SortMode>> getSortMode() async {
    try {
      final sortModeString =
          await _sharedPreferencesService.getString('sort_mode');
      if (sortModeString != null) {
        final sortMode = SortMode.values.firstWhere(
          (mode) => mode.name == sortModeString,
          // If the stored value doesn't match any enum, return default
          orElse: () => SortMode.createdAt,
        );
        return Success(sortMode);
      } else {
        // If no sort mode is set, return default
        return const Success(SortMode.createdAt);
      }
    } catch (error, stackTrace) {
      _logger.e('Error getting sort mode', error: error, stackTrace: stackTrace);
      return Failure(error as Exception);
    }
  }
}
