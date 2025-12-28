import 'package:material_task_tracker/domain/model/sort.dart';

/// The app bar UI state model for Home screen
// FIX: State should be immutable
class HomeAppBarUiState {
  bool isHideCompletedTasksIconActive;

  // Using a set as segmented button makes use of a set to represent selection
  SortMode sortMode;

  // Room for future filters
  HomeAppBarUiState({
    this.isHideCompletedTasksIconActive = false,
    this.sortMode = SortMode.createdAt,
  });

  // FIX: State should be immutable
  HomeAppBarUiState copyWith({
    bool? isHideCompletedTasksIconActive,
    SortMode? sortMode,
  }) => HomeAppBarUiState(
    isHideCompletedTasksIconActive:
        isHideCompletedTasksIconActive ?? this.isHideCompletedTasksIconActive,
    sortMode: sortMode ?? this.sortMode,
  );
}
